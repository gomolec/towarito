import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:towarito/core/navigation/app_router.dart';

import '../../../core/app/app_scaffold_messager.dart';
import '../../../domain/adapters/products_adapter.dart';
import '../../../injection_container.dart';
import '../../widgets/quantity_buttons.dart';
import 'bloc/product_bloc.dart';
import 'widgets/widgets.dart';

@RoutePage()
class ProductPage extends StatelessWidget {
  final String? productId;
  final String? productCode;

  const ProductPage({
    Key? key,
    @PathParam('id') this.productId,
    this.productCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(
        productsAdapter: sl<ProductsAdapter>(),
        appScaffoldMessager: sl<AppScaffoldMessager>(),
      )..add(ProductSubscriptionRequested(
          initialProductId: productId,
          initialProductCode: productCode,
        )),
      child: const ProductPageView(),
    );
  }
}

class ProductPageView extends StatefulWidget {
  const ProductPageView({super.key});

  @override
  State<ProductPageView> createState() => _ProductPageViewState();
}

class _ProductPageViewState extends State<ProductPageView> {
  late final ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state.status == ProductStatus.deleted) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
            Navigator.of(context).maybePop();
          }
          return;
        }
        if (state.status == ProductStatus.success) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
          if (state.initialProduct != null) {
            context.read<ProductBloc>().add(ProductSubscriptionRequested(
                  initialProductId: state.initialProduct!.id,
                ));
            return;
          }
          AutoRouter.of(context)
              .popAndPush(ProductRoute(productId: state.createdId));
        }
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status.canViewForm) {
          return Scaffold(
            extendBodyBehindAppBar:
                !state.isEditing && state.initialProduct?.imageUrl != null,
            appBar: ProductAppBar(
              scrollController: scrollController,
              backgroundColor: Theme.of(context).colorScheme.surface,
              isEditing: state.isEditing,
              bookmarked: state.bookmarked,
            ),
            body: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProductImage(
                    imageUrl: state.initialProduct?.imageUrl,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ProductNameField(),
                        const Divider(
                          thickness: 1.0,
                          height: 16.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Kod produktu",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurfaceVariant),
                                  ),
                                  const ProductCodeField()
                                ],
                              ),
                            ),
                            state.isEditing
                                ? Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Ostatnia aktualizacja",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurfaceVariant),
                                        ),
                                        Text(
                                          DateFormat("dd.MM.yyyy HH:mm").format(
                                              state.initialProduct!.updated),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                        const Divider(
                          thickness: 1.0,
                          height: 16.0,
                        ),
                        // ProductQuantityButtons(
                        //   initialQuantity: state.quantity,
                        //   initialTargetQuantity: state.targetQuantity,
                        // ),
                        QuantityButtons(
                          theme: Theme.of(context),
                          initialQuantity: state.quantity,
                          initialTargetQuantity: state.targetQuantity,
                          setQuantity: (value) => context
                              .read<ProductBloc>()
                              .add(ProductQuantityChanged(value)),
                          setTargetQuantity: (value) => context
                              .read<ProductBloc>()
                              .add(ProductTargetQuantityChanged(value)),
                        ),
                        const Divider(
                          thickness: 1.0,
                          height: 16.0,
                        ),
                        Text(
                          "Notatki",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant),
                        ),
                        const ProductNoteField(),
                        const Divider(
                          thickness: 1.0,
                          height: 16.0,
                        ),
                        const ProductLinkButton(),
                        const SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(title: const Text("Produkt")),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
