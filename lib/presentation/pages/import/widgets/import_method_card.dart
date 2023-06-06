import 'package:flutter/material.dart';

class ImportMethodCard extends StatelessWidget {
  final void Function()? onTap;
  final Widget icon;
  final String title;
  final String subtitle;
  final ThemeData? theme;

  const ImportMethodCard({
    Key? key,
    this.onTap,
    required this.icon,
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
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: onTap != null
                        ? theme?.colorScheme.primary
                        : theme?.colorScheme.onSurfaceVariant,
                    child: IconTheme(
                      data: IconThemeData(
                        color: theme?.colorScheme.onPrimary,
                      ),
                      child: icon,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 24.0,
                    color: onTap != null
                        ? theme?.colorScheme.onBackground
                        : theme?.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                title,
                style: theme?.textTheme.headlineSmall?.copyWith(
                  color: onTap != null
                      ? theme?.colorScheme.onBackground
                      : theme?.colorScheme.onSurfaceVariant,
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
      ),
    );
  }
}
