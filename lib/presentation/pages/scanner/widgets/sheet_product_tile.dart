import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/navigation/app_router.dart';
import '../../../../core/theme/custom_color.g.dart';
import '../../../../data/models/models.dart';

class SheetProductTile extends StatelessWidget {
  final Product product;
  final ThemeData theme;

  const SheetProductTile({
    Key? key,
    required this.product,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: () {
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
            color = theme.extension<CustomColors>()!.successContainer!;
            iconColor = theme.extension<CustomColors>()!.onSuccessContainer!;
          } else if (product.quantity == 0) {
            color = theme.colorScheme.onSurface.withOpacity(0.12);
            iconColor = theme.colorScheme.onSurface.withOpacity(0.76);
          } else {
            color = theme.extension<CustomColors>()!.warningContainer!;
            iconColor = theme.extension<CustomColors>()!.onWarningContainer!;
          }
        }
        return Container(
          alignment: Alignment.center,
          height: 56.0,
          width: 56.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          child: Icon(
            iconData,
            color: iconColor,
            size: 24.0,
          ),
        );
      }(),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      title: Text(product.name),
      subtitle: Text(product.code,
          style: theme.textTheme.bodyMedium
              ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
      onTap: () => AutoRouter.of(context).root.navigate(
            ProductRoute(productId: product.id),
          ),
    );
  }
}
