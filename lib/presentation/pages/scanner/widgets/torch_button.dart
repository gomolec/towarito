import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/scanner_bloc.dart';

class TorchButton extends StatelessWidget {
  const TorchButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final torchState = context
        .select<ScannerBloc, TorchState>((value) => value.state.torchState);
    return IconButton(
      onPressed: torchState == TorchState.unavailable ? null : () {},
      iconSize: 32.0,
      icon: Icon(torchState == TorchState.off
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
