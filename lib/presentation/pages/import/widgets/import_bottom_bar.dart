import 'package:flutter/material.dart';

class ImportBottomBar extends StatelessWidget {
  final String buttonText;
  final double progress;
  final void Function()? onTap;

  const ImportBottomBar({
    Key? key,
    required this.buttonText,
    required this.progress,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LinearProgressIndicator(
            value: progress,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: onTap,
                    child: Text(buttonText),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
