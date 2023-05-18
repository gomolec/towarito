import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app/app_scaffold_messager.dart';
import '../../../../core/navigation/app_router.dart';
import '../../../../core/theme/custom_color.g.dart';
import '../../../../data/models/models.dart';
import '../../../../domain/adapters/products_adapter.dart';
import '../../../../injection_container.dart';
import '../../../widgets/quantity_buttons.dart';
import '../bloc/product_bloc.dart';

class ProductBottomSheet extends StatelessWidget {
  final String code;

  const ProductBottomSheet({
    Key? key,
    required this.code,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(
        productsAdapter: sl<ProductsAdapter>(),
        appScaffoldMessager: sl<AppScaffoldMessager>(),
      )..add(ProductQueried(code)),
      child: const ProductBottomSheetView(),
    );
  }
}

class ProductBottomSheetView extends StatelessWidget {
  const ProductBottomSheetView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const DragableIndicator(),
        SizedBox(
          height: 296.0,
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state.status == ProductStatus.found) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProductTile(
                      product: state.product!,
                      theme: theme,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: QuantityButtons(
                        initialQuantity: state.product!.quantity,
                        initialTargetQuantity: state.product!.targetQuantity,
                        setQuantity: (value) => context
                            .read<ProductBloc>()
                            .add(ProductQuantityChanged(value)),
                        setTargetQuantity: (value) => context
                            .read<ProductBloc>()
                            .add(ProductTargetQuantityChanged(value)),
                        theme: theme,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        bottom: 24.0,
                        top: 8.0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: FilledButton.tonalIcon(
                              onPressed: state.didChanged
                                  ? () => context
                                      .read<ProductBloc>()
                                      .add(const ProductChangesSaved())
                                  : null,
                              icon: const Icon(Icons.save_alt_rounded),
                              label: const Text("Zapisz"),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: FilledButton.tonalIcon(
                              onPressed: () => context
                                  .read<ProductBloc>()
                                  .add(const ProductBookmarkingChanged()),
                              icon: Icon(state.product!.bookmarked
                                  ? Icons.flag
                                  : Icons.flag_outlined),
                              label: Text(state.product!.bookmarked
                                  ? "Odflaguj"
                                  : "Oflaguj"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              if (state.status == ProductStatus.notFound) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 8.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Nie znaleziono produktu",
                        style: theme.textTheme.headlineSmall,
                      ),
                      Text(
                        "Produkt z tym kodem nie znajduje się w bazie, spróbuj zeskanować ponownie lub utworzyć nowy przy użyciu przycisku na dole.",
                        style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: theme.colorScheme.outline,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: Icon(
                                Icons.link_rounded,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            Expanded(
                              child: SelectableText(
                                state.code,
                                style: theme.textTheme.titleMedium,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                              ),
                            ),
                            InkWell(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                              onTap: () {
                                Clipboard.setData(
                                        ClipboardData(text: state.code))
                                    .then((_) {
                                  sl<AppScaffoldMessager>().showSnackbar(
                                      message: "Kod został skopiowany");
                                });
                              },
                              child: Container(
                                height: 40.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.secondaryContainer,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                  vertical: 8.0,
                                ),
                                child: Text(
                                  "Kopiuj",
                                  style: theme.textTheme.labelLarge?.copyWith(
                                      color: theme
                                          .colorScheme.onSecondaryContainer),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          right: 16.0,
                          bottom: 24.0,
                          top: 8.0,
                        ),
                        child: FilledButton.tonalIcon(
                          onPressed: () => AutoRouter.of(context).root.navigate(
                                ProductRoute(productCode: state.code),
                              ),
                          icon: const Icon(Icons.add_rounded),
                          label: const Text("Utwórz nowy produkt"),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ProductTile extends StatelessWidget {
  final Product product;
  final ThemeData theme;

  const ProductTile({
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

class DragableIndicator extends StatelessWidget {
  const DragableIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24.0,
        bottom: 16.0,
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
