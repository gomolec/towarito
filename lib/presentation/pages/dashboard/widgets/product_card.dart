import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final void Function()? onTap;
  final ThemeData? theme;
  final double? width;
  final double? height;

  const ProductCard({
    Key? key,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.theme,
    this.width,
    this.height,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 6 / 5,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme?.colorScheme.primaryContainer,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Icon(
                    Icons.inventory_2_outlined,
                    color: theme?.colorScheme.onPrimary,
                    size: 64.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme?.textTheme.titleMedium,
                    ),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme?.textTheme.bodyMedium?.copyWith(
                        color: theme?.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
