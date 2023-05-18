part of 'scanner_bloc.dart';

enum ScannerStatus { loading, paused, scanning }

enum FlashlightState { on, off, unavailable }

class ScannerState extends Equatable {
  final ScannerStatus status;
  final FlashlightState torchState;
  final bool currentSessionActive;
  final String? barcode;

  const ScannerState({
    this.status = ScannerStatus.loading,
    this.torchState = FlashlightState.unavailable,
    this.currentSessionActive = false,
    this.barcode,
  });

  ScannerState copyWith({
    ScannerStatus? status,
    FlashlightState? torchState,
    bool? currentSessionActive,
    String? Function()? barcode,
  }) {
    return ScannerState(
      status: status ?? this.status,
      torchState: torchState ?? this.torchState,
      currentSessionActive: currentSessionActive ?? this.currentSessionActive,
      barcode: barcode != null ? barcode() : this.barcode,
    );
  }

  @override
  String toString() =>
      'ScannerState(status: $status, torchState: $torchState, currentSessionActive: $currentSessionActive, barcode: $barcode)';

  @override
  List<Object?> get props => [
        status,
        torchState,
        currentSessionActive,
        barcode,
      ];
}
