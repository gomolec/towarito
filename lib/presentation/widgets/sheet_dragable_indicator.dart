import 'package:flutter/material.dart';

class SheetDragableIndicator extends StatelessWidget {
  const SheetDragableIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24.0, //22.0
        bottom: 16.0, //8.0
      ),
      child: Container(
        width: 32.0,
        height: 4.0,
        decoration: BoxDecoration(
          color:
              Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.4),
          borderRadius: BorderRadius.circular(2.0),
        ),
      ),
    );
  }
}
