import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:towarito/core/app/app_scaffold_messager.dart';
import 'package:towarito/domain/adapters/products_adapter.dart';
import 'package:towarito/presentation/pages/scanner/widgets/product_bottom_sheet.dart';

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
        productsAdapter: sl<ProductsAdapter>(),
        appScaffoldMessager: sl<AppScaffoldMessager>(),
      ),
      child: const Scaffold(),
      //child: const ScannerPageView(),
    );
  }
}

class ScannerPageView extends StatefulWidget {
  const ScannerPageView({super.key});

  @override
  State<ScannerPageView> createState() => _ScannerPageViewState();
}

class _ScannerPageViewState extends State<ScannerPageView> {
  //late final RoutingController _router;
  late final MobileScannerController _cameraController;

  @override
  void initState() {
    //_router = AutoRouter.of(context);
    _cameraController = MobileScannerController();
    //_router.addListener(onActivePage);
    context.read<ScannerBloc>().add(ScannerSubscriptionRequested(
        isTorchAvailable: _cameraController.hasTorch));
    super.initState();
  }

  // void onActivePage() async {
  //   await Future.delayed(const Duration(milliseconds: 10));
  //   if (_cameraController.isStarting) {
  //     return;
  //   }
  //   if (_router.isRouteActive(ScannerRoute.name)) {
  //     await _cameraController.start();
  //     return;
  //   }
  //   await _cameraController.stop();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ScannerBloc, ScannerState>(
      listener: (context, state) {
        if (state.status == ScannerStatus.success &&
            state.scannedBarcode != null) {
          showModalBottomSheet(
            isScrollControlled: true,
            useRootNavigator: true,
            elevation: 1.0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(28.0)),
            ),
            context: context,
            builder: (BuildContext context) {
              return const ProductBottomSheet();
            },
          );
        }
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(
            controller: _cameraController,
            fit: BoxFit.cover,
            onDetect: (barcode) {
              final value = barcode.barcodes.first.displayValue;
              log(value.toString());
              if (value != null) {
                context
                    .read<ScannerBloc>()
                    .add(ScannerBarcodeDetected(barcode: value));
              }
            },
          ),
          const Positioned.fill(
            child: ScannerOverlay(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    //_router.removeListener(onActivePage);
    _cameraController.dispose();
    super.dispose();
  }
}
