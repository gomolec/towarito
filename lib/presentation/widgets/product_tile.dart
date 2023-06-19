import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/navigation/app_router.dart';
import '../../core/theme/custom_color.g.dart';
import '../../data/models/models.dart';
import 'custom_popup_menu_item.dart';
import '../pages/products/bloc/products_bloc/products_bloc.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AutoRouter.of(context)
          .root
          .navigate(ProductRoute(productId: product.id)),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 24.0,
          top: 12.0,
          bottom: 12.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            () {
              late final Color color;
              late final IconData iconData;
              late final Color iconColor;
              if (product.bookmarked) {
                color = Theme.of(context).colorScheme.errorContainer;
                iconData = Icons.flag_outlined;
                iconColor = Theme.of(context).colorScheme.onErrorContainer;
              } else {
                iconData = Icons.inventory_2_outlined;
                if (product.quantity == product.targetQuantity) {
                  color = Theme.of(context)
                      .extension<CustomColors>()!
                      .successContainer!;
                  iconColor = Theme.of(context)
                      .extension<CustomColors>()!
                      .onSuccessContainer!;
                } else if (product.quantity == 0) {
                  color =
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.12);
                  iconColor =
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.76);
                } else {
                  color = Theme.of(context)
                      .extension<CustomColors>()!
                      .warningContainer!;
                  iconColor = Theme.of(context)
                      .extension<CustomColors>()!
                      .onWarningContainer!;
                }
              }
              bool hasImage = product.imageUrl != null;
              return Container(
                alignment: hasImage ? Alignment.topRight : Alignment.center,
                height: 56.0,
                width: 56.0,
                decoration: BoxDecoration(
                    color: hasImage ? null : color,
                    image: hasImage
                        ? DecorationImage(
                            image: Image.network(product.imageUrl!).image,
                            fit: BoxFit.cover,
                          )
                        : null,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                    )),
                child: Icon(
                  iconData,
                  color: iconColor,
                  size: hasImage ? 8.0 : 24.0,
                ),
              );
            }(),
            const SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.code,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.layers_outlined,
                        size: 16.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        "Ilość ${product.quantity} z ${product.targetQuantity} szt.",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  product.note.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.notes_rounded,
                                size: 16.0,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                              const SizedBox(width: 4.0),
                              Expanded(
                                child: Text(
                                  product.note,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            const SizedBox(
              width: 16.0,
            ),
            Container(
              alignment: Alignment.center,
              height: 56.0,
              child: PopupMenuButton(
                tooltip: "Pokaż opcje",
                icon: const Icon(Icons.more_vert_rounded),
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  CustomPopupMenuItem(
                    title: "Edytuj",
                    iconData: Icons.edit_note_rounded,
                    onTap: () => AutoRouter.of(context)
                        .root
                        .navigate(ProductRoute(productId: product.id)),
                  ),
                  CustomPopupMenuItem(
                    title: product.bookmarked ? "Usuń przypięcie" : "Przypnij",
                    iconData:
                        product.bookmarked ? Icons.flag_outlined : Icons.flag,
                    onTap: () => context
                        .read<ProductsBloc>()
                        .add(ProductBookmarkingToggled(product: product)),
                  ),
                  const PopupMenuDivider(),
                  CustomPopupMenuItem(
                    title: "Usuń",
                    iconData: Icons.delete_outlined,
                    onTap: () => context
                        .read<ProductsBloc>()
                        .add(ProductDeleted(id: product.id)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
