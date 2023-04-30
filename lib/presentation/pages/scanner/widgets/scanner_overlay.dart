import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'scanner_info_text.dart';
import 'torch_button.dart';

class ScannerOverlay extends StatelessWidget {
  const ScannerOverlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              children: const [
                ScannerInfoText(),
              ],
            ),
          ),
          const Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: RiveAnimation.asset(
                'assets/scanner_overlay.riv',
              ),
            ),
          ),
          const Expanded(
            flex: 4,
            child: Center(
              child: TorchButton(),
            ),
          ),
        ],
      ),
    );
  }
}
