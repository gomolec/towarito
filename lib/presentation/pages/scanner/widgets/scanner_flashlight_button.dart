import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/scanner_bloc.dart';

class ScannerFlashlightButton extends StatelessWidget {
  const ScannerFlashlightButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final torchState = context.select<ScannerBloc, FlashlightState>(
        (value) => value.state.torchState);
    return IconButton(
      onPressed: torchState == FlashlightState.unavailable ? null : () {},
      iconSize: 32.0,
      icon: Icon(torchState == FlashlightState.off
          ? Icons.flashlight_on_rounded
          : Icons.flashlight_off_rounded),
      tooltip: "Przełącz lampę błyskową",
      padding: const EdgeInsets.all(16.0),
      style: IconButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.background,
        backgroundColor:
            Theme.of(context).colorScheme.onBackground.withOpacity(0.64),
      ),
    );
  }
}
