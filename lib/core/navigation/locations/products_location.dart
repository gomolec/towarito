import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../../../presentation/pages/pages.dart';

class ProductsLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => [
        '/products',
        '/products/new',
        '/products/:productId',
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        const BeamPage(
          key: ValueKey('products'),
          title: 'Products',
          type: BeamPageType.noTransition,
          child: ProductsPage(),
        ),
        if (state.uri.pathSegments.contains('new'))
          const BeamPage(
            key: ValueKey('product-new'),
            title: 'New product',
            type: BeamPageType.noTransition,
            child: ProductPage(),
          ),
        if (state.pathParameters.containsKey('productId'))
          BeamPage(
            key: ValueKey('product-${state.pathParameters['productId']}'),
            title: 'Edit product',
            type: BeamPageType.noTransition,
            child: ProductPage(productId: state.pathParameters['productId']),
          ),
      ];
}
