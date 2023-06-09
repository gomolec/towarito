part of 'scanner_bloc.dart';

abstract class ScannerEvent extends Equatable {
  const ScannerEvent();

  @override
  List<Object> get props => [];
}

class ScannerSubscriptionRequested extends ScannerEvent {
  final bool flashlightAvailable;

  const ScannerSubscriptionRequested({
    required this.flashlightAvailable,
  });

  @override
  List<Object> get props => [flashlightAvailable];
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
  final FlashlightState state;

  const ScannerFlashlightToggled({
    required this.state,
  });

  @override
  List<Object> get props => [state];
}

class ScannerResumed extends ScannerEvent {
  const ScannerResumed();
}

class ScannerPaused extends ScannerEvent {
  const ScannerPaused();
}
