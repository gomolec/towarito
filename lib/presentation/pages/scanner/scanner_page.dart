import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../core/app/app_scaffold_messager.dart';
import 'widgets/product_bottom_sheet.dart';

import '../../../core/navigation/app_router.dart';
import '../../../domain/adapters/sessions_adapter.dart';
import '../../../injection_container.dart';
import 'bloc/scanner_bloc.dart';
import 'widgets/scanner_overlay.dart';

@RoutePage()
class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScannerBloc(
        sessionsAdapter: sl<SessionsAdapter>(),
        appScaffoldMessager: sl<AppScaffoldMessager>(),
      ),
      child: const ScannerPageView(),
    );
  }
}

class ScannerPageView extends StatefulWidget {
  const ScannerPageView({super.key});

  @override
  State<ScannerPageView> createState() => _ScannerPageViewState();
}

class _ScannerPageViewState extends State<ScannerPageView> {
  late final RoutingController _router;
  late final MobileScannerController _cameraController;

  @override
  void initState() {
    _router = AutoRouter.of(context).root;
    _cameraController = MobileScannerController(
      detectionTimeoutMs: 500,
    );
    _router.addListener(onActivePage);
    context.read<ScannerBloc>().add(ScannerSubscriptionRequested(
          flashlightAvailable: _cameraController.hasTorch,
        ));
    super.initState();
  }

  void onActivePage() async {
    await Future.delayed(const Duration(milliseconds: 10));
    if (_cameraController.isStarting) {
      return;
    }
    if (_router.isRouteActive(ScannerRouterRoute.name)) {
      await _cameraController.start();

      return;
    }
    await _cameraController.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        BlocListener<ScannerBloc, ScannerState>(
          listenWhen: (previous, current) =>
              previous.barcode != current.barcode,
          listener: (context, state) async {
            if (state.barcode != null) {
              await showModalBottomSheet(
                isScrollControlled: true,
                elevation: 1.0,
                shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(28.0)),
                ),
                context: context,
                builder: (BuildContext context) {
                  return ProductBottomSheet(
                    code: state.barcode!,
                  );
                },
              );
              if (!mounted) {
                return;
              }
              context.read<ScannerBloc>().add(const ScannerResumed());
            }
          },
          child: MobileScanner(
            controller: _cameraController,
            fit: BoxFit.cover,
            onDetect: (barcode) {
              final value = barcode.barcodes.first.displayValue;
              if (value != null) {
                context
                    .read<ScannerBloc>()
                    .add(ScannerBarcodeDetected(barcode: value));
              }
            },
          ),
        ),
        const Positioned.fill(child: ScannerOverlay()),
      ],
    );
  }

  @override
  void dispose() {
    _router.removeListener(onActivePage);
    _cameraController.dispose();
    super.dispose();
  }
}
