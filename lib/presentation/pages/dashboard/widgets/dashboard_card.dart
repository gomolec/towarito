import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final Icon icon;
  final String title;
  final String subtitle;
  final ThemeData? theme;
  final double? width;
  final double? height;
  final void Function()? onTap;

  const DashboardCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.theme,
    this.width,
    this.height,
    this.onTap,
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
        child: SizedBox(
          width: width,
          height: height,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: theme?.colorScheme.primary,
                      child: IconTheme(
                        data: IconThemeData(
                          color: theme?.colorScheme.onPrimary,
                        ),
                        child: icon,
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      size: 24.0,
                    ),
                  ],
                ),
                Text(
                  title,
                  style: theme?.textTheme.headlineSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  subtitle,
                  style: theme?.textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
