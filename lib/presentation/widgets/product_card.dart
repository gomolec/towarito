import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../core/navigation/app_router.dart';
import '../../core/theme/custom_color.g.dart';
import '../../data/models/models.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final ThemeData theme;
  final double? width;
  final double? height;

  const ProductCard({
    Key? key,
    required this.product,
    required this.theme,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: theme.colorScheme.outline,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      margin: EdgeInsets.zero,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => AutoRouter.of(context)
            .root
            .navigate(ProductRoute(productId: product.id)),
        child: SizedBox(
          width: width,
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: () {
                  late final Color color;
                  late final IconData iconData;
                  late final Color iconColor;
                  if (product.bookmarked) {
                    color = theme.colorScheme.errorContainer;
                    iconData = Icons.flag_outlined;
                    iconColor = theme.colorScheme.onErrorContainer;
                  } else {
                    iconData = Icons.inventory_2_outlined;
                    if (product.quantity == product.targetQuantity) {
                      color =
                          theme.extension<CustomColors>()!.successContainer!;
                      iconColor =
                          theme.extension<CustomColors>()!.onSuccessContainer!;
                    } else if (product.quantity == 0) {
                      color = theme.colorScheme.onSurface.withOpacity(0.12);
                      iconColor = theme.colorScheme.onSurface.withOpacity(0.76);
                    } else {
                      color =
                          theme.extension<CustomColors>()!.warningContainer!;
                      iconColor =
                          theme.extension<CustomColors>()!.onWarningContainer!;
                    }
                  }
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: Icon(
                      iconData,
                      color: iconColor,
                      size: 64.0,
                    ),
                  );
                }(),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      product.code,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
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
