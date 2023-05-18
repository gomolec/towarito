import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/app/app_scaffold_messager.dart';
import '../../../../domain/adapters/sessions_adapter.dart';
import '../../../../domain/entities/sessions_entity.dart';

part 'scanner_event.dart';
part 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  final SessionsAdapter _sessionsAdapter;
  final AppScaffoldMessager _appScaffoldMessager;

  ScannerBloc({
    required SessionsAdapter sessionsAdapter,
    required AppScaffoldMessager appScaffoldMessager,
  })  : _sessionsAdapter = sessionsAdapter,
        _appScaffoldMessager = appScaffoldMessager,
        super(const ScannerState()) {
    on<ScannerSubscriptionRequested>(_onSubscriptionRequested);
    on<ScannerBarcodeDetected>(_onBarcodeDetected);
    on<ScannerFlashlightToggled>(_onFlashlightToggled);
    on<ScannerResumed>(_onResumed);
    on<ScannerPaused>(_onPaused);
  }

  bool _currentSessionActive = false;

  Future<void> _onSubscriptionRequested(
    ScannerSubscriptionRequested event,
    Emitter<ScannerState> emit,
  ) async {
    emit(state.copyWith(
      torchState: event.flashlightAvailable
          ? FlashlightState.off
          : FlashlightState.unavailable,
    ));
    await emit.onEach<SessionsEntity>(
      _sessionsAdapter.observeSessionsData(),
      onData: (data) {
        if (data.hasCurrentSession == _currentSessionActive) {
          return;
        }
        _currentSessionActive = data.hasCurrentSession;
        if (!data.hasCurrentSession) {
          emit(state.copyWith(
            status: ScannerStatus.paused,
            currentSessionActive: _currentSessionActive,
            barcode: () => null,
          ));
          return;
        }
        emit(state.copyWith(
          status: ScannerStatus.scanning,
          currentSessionActive: _currentSessionActive,
          barcode: () => null,
        ));
      },
      onError: (error, stackTrace) {
        emit(state.copyWith(
          status: ScannerStatus.paused,
          currentSessionActive: false,
          barcode: () => null,
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
    if (state.status != ScannerStatus.scanning) {
      return;
    }
    emit(state.copyWith(
      status: ScannerStatus.paused,
      barcode: () => event.barcode,
    ));
  }

  void _onFlashlightToggled(
    ScannerFlashlightToggled event,
    Emitter<ScannerState> emit,
  ) {
    if (state.torchState == FlashlightState.unavailable) {
      return;
    }
    emit(state.copyWith(
      torchState: event.state == FlashlightState.on
          ? FlashlightState.off
          : FlashlightState.on,
      barcode: () => null,
    ));
  }

  void _onResumed(
    ScannerResumed event,
    Emitter<ScannerState> emit,
  ) {
    emit(state.copyWith(
      status: ScannerStatus.scanning,
      barcode: () => null,
    ));
  }

  void _onPaused(
    ScannerPaused event,
    Emitter<ScannerState> emit,
  ) {
    emit(state.copyWith(
      status: ScannerStatus.paused,
      barcode: () => null,
    ));
  }
}
