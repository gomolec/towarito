import '../../data/models/models.dart';

class ProductsSorter {
  const ProductsSorter();

  List<Product> sortProducts({
    required List<Product> products,
    required ProductsFilter filter,
  }) {
    List<Product> filteredProducts = List.of(products);

    if (filter.showCompleted == false && filter.showMarked == false) {
      filteredProducts.removeWhere((element) =>
          element.quantity >= element.targetQuantity ||
          element.bookmarked == true);
    } else if (filter.showCompleted == false) {
      filteredProducts
          .removeWhere((element) => element.quantity >= element.targetQuantity);
    } else if (filter.showMarked == false) {
      filteredProducts.removeWhere((element) => element.bookmarked == true);
    }

    switch (filter.sorting) {
      case ProductsSortingType.name:
        filteredProducts.sort((a, b) => a.name.compareTo(b.name));
        break;
      case ProductsSortingType.update:
        filteredProducts.sort((a, b) => a.updated.isBefore(b.updated) ? -1 : 1);
        break;
      case ProductsSortingType.quantity:
        filteredProducts.sort((a, b) => a.quantity.compareTo(b.quantity));
        break;
    }

    if (!filter.ascendingSorting) {
      filteredProducts = filteredProducts.reversed.toList();
    }

    //sortuje na góre oflagowane produkty
    filteredProducts.sort((a, b) => a.bookmarked || !b.bookmarked ? -1 : 1);

    return filteredProducts;
  }
}
