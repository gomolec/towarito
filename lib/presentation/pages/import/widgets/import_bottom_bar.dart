import 'package:flutter/material.dart';

class ImportBottomBar extends StatelessWidget {
  const ImportBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const LinearProgressIndicator(
            value: 0.25,
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
                    onPressed: () {},
                    child: const Text("Przejdz dalej"),
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
