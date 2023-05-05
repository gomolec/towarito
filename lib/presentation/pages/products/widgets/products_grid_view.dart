import 'package:flutter/material.dart';

import '../../../../data/models/models.dart';
import '../../../widgets/product_card.dart';

class ProductsGridView extends StatelessWidget {
  final List<Product> products;

  const ProductsGridView({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 2 / 3,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final Product product = products[index];
            return ProductCard(
              product: product,
              theme: Theme.of(context),
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }
}
