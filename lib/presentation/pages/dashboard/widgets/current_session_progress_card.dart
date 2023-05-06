import 'package:flutter/material.dart';

class CurrentSessionProgressCard extends StatelessWidget {
  final int value;
  final double? width;
  final double? height;
  final ThemeData? theme;

  const CurrentSessionProgressCard({
    Key? key,
    required this.value,
    this.width,
    this.height,
    this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      margin: EdgeInsets.zero,
      child: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: LayoutBuilder(
                  builder: (context, BoxConstraints constraints) {
                    final size = constraints.maxWidth > constraints.maxHeight
                        ? constraints.maxHeight
                        : constraints.maxWidth;
                    return Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: size,
                        height: size,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: CircularProgressIndicator(
                            backgroundColor: theme?.colorScheme.surfaceVariant,
                            strokeWidth: 12.0,
                            value: value == 0 ? 0.01 : value / 100,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16.0),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Postęp aktualnej sesji",
                    style: theme?.textTheme.headlineSmall,
                  ),
                  Text(
                    "${100 - value}% do ukończenia",
                    style: theme?.textTheme.bodyMedium?.copyWith(
                      color: theme?.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
