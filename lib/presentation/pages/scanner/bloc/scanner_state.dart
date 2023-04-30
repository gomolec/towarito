part of 'scanner_bloc.dart';

enum ScannerStatus { initial, loading, noSession, success, failure }

enum TorchState { on, off, unavailable }

class ScannerState extends Equatable {
  final ScannerStatus status;
  final TorchState torchState;
  final String? scannedBarcode;
  final Failure? failure;

  const ScannerState({
    this.status = ScannerStatus.initial,
    this.torchState = TorchState.unavailable,
    this.scannedBarcode,
    this.failure,
  });

  ScannerState copyWith({
    ScannerStatus? status,
    TorchState? torchState,
    String? Function()? scannedBarcode,
    Failure? Function()? failure,
  }) {
    return ScannerState(
      status: status ?? this.status,
      torchState: torchState ?? this.torchState,
      scannedBarcode:
          scannedBarcode != null ? scannedBarcode() : this.scannedBarcode,
      failure: failure != null ? failure() : this.failure,
    );
  }

  @override
  String toString() {
    return 'ScannerState(status: $status, torchState: $torchState, scannedBarcode: $scannedBarcode, failure: $failure)';
  }

  @override
  List<Object?> get props => [
        status,
        torchState,
        scannedBarcode,
        failure,
      ];
}
