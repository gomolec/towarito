import 'package:flutter/material.dart';

import '../../../../data/models/models.dart';
import '../../../widgets/product_tile.dart';

class ProductsListView extends StatelessWidget {
  final List<Product> products;

  const ProductsListView({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Column(
            children: [
              ProductTile(
                product: products[index],
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
        childCount: products.length,
      ),
    );
  }
}
