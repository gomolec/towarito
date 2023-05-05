import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/navigation/router.gr.dart';
import '../../../../data/models/models.dart';
import '../../../widgets/page_alert.dart';
import '../bloc/products_bloc/products_bloc.dart';
import 'widgets.dart';

class ProductsView extends StatelessWidget {
  final ProductsState state;
  final ScrollController controller;

  const ProductsView({
    Key? key,
    required this.state,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = context
        .select<ProductsBloc, ProductsFilter>((data) => data.state.filter);
    return Scrollbar(
      controller: controller,
      interactive: true,
      child: CustomScrollView(
        controller: controller,
        slivers: [
          ProductsSliverAppBar(
            filter: filter,
            initialFilter: state.filter,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                SearchBar(
                  onSubmitted: (value) =>
                      context.read<ProductsBloc>().add(ProductsQueried(value)),
                ),
                const Divider(
                  height: 8,
                  thickness: 1,
                ),
              ],
            ),
          ),
          () {
            if (state.products.isNotEmpty) {
              switch (filter.view) {
                case ProductsViewType.list:
                  return ProductsListView(products: state.products);
                case ProductsViewType.grid:
                  return ProductsGridView(products: state.products);
              }
            } else {
              if (state.query.isNotEmpty || !state.filter.isDefault) {
                return const SliverToBoxAdapter(
                  child: PageAlert(
                    leadingIconData: Icons.search_off_rounded,
                    title: "Brak znalezionych produktów",
                    text:
                        "\tNie znaleziono żadnych produktów pasujących do twoich preferencji. Spróbuj zmienić opcje filtrowania lub frazę wyszukiwania.",
                  ),
                );
              } else {
                return SliverToBoxAdapter(
                  child: PageAlert(
                    leadingIconData: Icons.folder_off_rounded,
                    title: "Brak produktów",
                    text:
                        "\tPo dodaniu produktów do sesji, ich podgląd bedzie znajdować się tutaj. Z tego ekranu możesz je łatwo usuwać, dodawać lub edytować ich właściwości.",
                    buttons: [
                      ElevatedButton.icon(
                        onPressed: () {
                          context.router.push(ProductRoute());
                        },
                        icon: const Icon(Icons.add),
                        label: const Text("Dodaj produkt"),
                      ),
                    ],
                  ),
                );
              }
            }
          }()
        ],
      ),
    );
  }
}
