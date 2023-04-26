import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/navigation/router.gr.dart';
import '../../../../data/models/models.dart';
import '../../../widgets/page_alert.dart';
import '../bloc/products_bloc/products_bloc.dart';
import 'widgets.dart';

class ProductsList extends StatelessWidget {
  final ProductsState state;
  final ScrollController controller;

  const ProductsList({
    Key? key,
    required this.state,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDefaultSorting = context
        .select<ProductsBloc, bool>((data) => data.state.filter.isDefault);
    return Scrollbar(
      controller: controller,
      interactive: true,
      child: CustomScrollView(
        controller: controller,
        slivers: [
          SliverAppBar.medium(
            title: const Text("Produkty"),
            actions: [
              IconButton(
                icon: const Icon(Icons.filter_alt_outlined),
                tooltip: "Filtruj",
                color: isDefaultSorting
                    ? null
                    : Theme.of(context).colorScheme.primary,
                onPressed: ([bool mounted = true]) async {
                  final filter = await showModalBottomSheet<ProductsFilter>(
                    isScrollControlled: true,
                    elevation: 1.0,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(28.0)),
                    ),
                    context: context,
                    builder: (BuildContext context) {
                      return SortingBottomSheet(
                        initialFilter: state.filter,
                      );
                    },
                  );
                  if (filter == null) {
                    return;
                  }
                  if (!mounted) {
                    return;
                  }
                  context
                      .read<ProductsBloc>()
                      .add(ProductsAppliedFilter(filter));
                },
              ),
              IconButton(
                onPressed: () {
                  context.router.push(ProductRoute());
                },
                tooltip: "Nowy produkt",
                icon: const Icon(Icons.add_rounded),
              ),
            ],
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
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Column(
                      children: [
                        ProductTile(
                          product: state.products[index],
                        ),
                        const Divider(
                          height: 8,
                          thickness: 1,
                          indent: 16,
                          endIndent: 16,
                        ),
                      ],
                    );
                  },
                  childCount: state.products.length,
                ),
              );
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
