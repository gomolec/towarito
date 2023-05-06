import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/models.dart';
import '../bloc/products_bloc/products_bloc.dart';
import 'widgets.dart';

class ProductsSliverAppBar extends StatelessWidget {
  final ProductsFilter filter;
  final ProductsFilter initialFilter;

  const ProductsSliverAppBar({
    Key? key,
    required this.filter,
    required this.initialFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.medium(
      title: const Text("Produkty"),
      actions: [
        IconButton(
          icon: const Icon(Icons.filter_alt_outlined),
          tooltip: "Filtruj",
          color:
              filter.isDefault ? null : Theme.of(context).colorScheme.primary,
          onPressed: ([bool mounted = true]) async {
            final filter = await showModalBottomSheet<ProductsFilter>(
              isScrollControlled: true,
              elevation: 1.0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(28.0)),
              ),
              context: context,
              builder: (BuildContext context) {
                return SortingBottomSheet(
                  initialFilter: initialFilter,
                );
              },
            );
            if (filter == null) {
              return;
            }
            if (!mounted) {
              return;
            }
            context.read<ProductsBloc>().add(ProductsAppliedFilter(filter));
          },
        ),
        IconButton(
          onPressed: () {
            context.beamToNamed('/products/new');
          },
          tooltip: "Nowy produkt",
          icon: const Icon(Icons.add_rounded),
        ),
      ],
    );
  }
}
