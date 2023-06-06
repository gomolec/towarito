import 'package:flutter/material.dart';

class ImportSummaryCard extends StatelessWidget {
  final Widget icon;
  final Color iconBackgroundColor;
  final String title;
  final String subtitle;
  final ThemeData? theme;

  const ImportSummaryCard({
    Key? key,
    required this.icon,
    required this.iconBackgroundColor,
    required this.title,
    required this.subtitle,
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
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: iconBackgroundColor,
              child: IconTheme(
                data: IconThemeData(
                  color: theme?.colorScheme.onSecondary,
                ),
                child: icon,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: theme?.textTheme.headlineSmall?.copyWith(
                color: theme?.colorScheme.onBackground,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 8.0),
            Text(
              subtitle,
              style: theme?.textTheme.bodyMedium?.copyWith(
                color: theme?.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
