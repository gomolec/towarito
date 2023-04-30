import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/app/app_scaffold_messager.dart';
import '../../../../core/error/failures.dart';
import '../../../../domain/adapters/products_adapter.dart';
import '../../../../domain/entities/products_entity.dart';

part 'scanner_event.dart';
part 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  final ProductsAdapter _productsAdapter;
  final AppScaffoldMessager _appScaffoldMessager;

  ScannerBloc({
    required ProductsAdapter productsAdapter,
    required AppScaffoldMessager appScaffoldMessager,
  })  : _productsAdapter = productsAdapter,
        _appScaffoldMessager = appScaffoldMessager,
        super(const ScannerState()) {
    on<ScannerSubscriptionRequested>(_onSubscriptionRequested);
    on<ScannerBarcodeDetected>(_onBarcodeDetected);
    on<ScannerFlashlightToggled>(_onFlashlightToggled);
  }

  Future<void> _onSubscriptionRequested(
    ScannerSubscriptionRequested event,
    Emitter<ScannerState> emit,
  ) async {
    emit(state.copyWith(
      status: ScannerStatus.loading,
      torchState:
          event.isTorchAvailable ? TorchState.off : TorchState.unavailable,
    ));
    await emit.onEach<ProductsEntity>(
      _productsAdapter.observeProductsData(),
      onData: (data) {
        log(data.toString());
        if (data.isSessionOpened) {
          emit(state.copyWith(
            status: ScannerStatus.success,
          ));
          return;
        }
        emit(state.copyWith(
          status: ScannerStatus.noSession,
        ));
      },
      onError: (error, stackTrace) {
        emit(state.copyWith(
          status: ScannerStatus.failure,
          failure: () => UnnamedFailure(error.toString()),
        ));
        _appScaffoldMessager.showSnackbar(message: error.toString());
      },
    );
  }

  Future<void> _onBarcodeDetected(
    ScannerBarcodeDetected event,
    Emitter<ScannerState> emit,
  ) async {
    if (event.barcode.isEmpty) {
      return;
    }
    if (state.status == ScannerStatus.noSession) {
      return;
    }
    emit(state.copyWith(
      status: ScannerStatus.success,
      scannedBarcode: () => event.barcode,
    ));
  }

  void _onFlashlightToggled(
    ScannerFlashlightToggled event,
    Emitter<ScannerState> emit,
  ) {
    if (state.torchState == TorchState.unavailable) {
      return;
    }
    emit(state.copyWith(
      torchState: event.state == TorchState.on ? TorchState.off : TorchState.on,
      scannedBarcode: () => null,
    ));
  }
}
