import 'package:diacritic/diacritic.dart';

import '../../data/models/models.dart';

class ProductsQuerier {
  const ProductsQuerier();

  List<Product> query(List<Product> products, String query) {
    if (query.isEmpty) {
      return products;
    }

    if (products.isEmpty) {
      return products;
    }

    return products
        .where((element) =>
            (removeDiacritics(element.name.toLowerCase()) + element.code)
                .contains(removeDiacritics(query).toLowerCase()))
        .toList();
  }
}
