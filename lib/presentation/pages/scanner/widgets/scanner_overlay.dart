import 'package:flutter/material.dart';
import 'widgets.dart';

class ScannerOverlay extends StatelessWidget {
  const ScannerOverlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: const [
          Expanded(
            flex: 4,
            child: ScannerInfoText(),
          ),
          Expanded(
            flex: 5,
            child: ScannerAnimatedIndicator(),
          ),
          Expanded(
            flex: 4,
            child: Center(
              child: ScannerFlashlightButton(),
            ),
          ),
        ],
      ),
    );
  }
}
