part of 'scanner_bloc.dart';

abstract class ScannerEvent extends Equatable {
  const ScannerEvent();

  @override
  List<Object> get props => [];
}

class ScannerSubscriptionRequested extends ScannerEvent {
  final bool isTorchAvailable;

  const ScannerSubscriptionRequested({
    required this.isTorchAvailable,
  });

  @override
  List<Object> get props => [isTorchAvailable];
}

class ScannerBarcodeDetected extends ScannerEvent {
  final String barcode;

  const ScannerBarcodeDetected({
    required this.barcode,
  });

  @override
  List<Object> get props => [barcode];
}

class ScannerFlashlightToggled extends ScannerEvent {
  final TorchState state;

  const ScannerFlashlightToggled({
    required this.state,
  });

  @override
  List<Object> get props => [state];
}
