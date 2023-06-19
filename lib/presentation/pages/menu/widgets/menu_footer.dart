import 'package:flutter/material.dart';

class MenuFooter extends StatelessWidget {
  const MenuFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        bottom: 8.0,
      ),
      child: Text(
        """Wersja 0.3.5\nCopyright © 2023 Sebastian Gomolec\ngomolecs@gmail.com\nAll rights reserved""",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
      ),
    );
  }
}
