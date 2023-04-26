import 'package:equatable/equatable.dart';

enum ProductsViewType { grid, list }

enum ProductsSortingType { name, update, quantity }

class ProductsFilter extends Equatable {
  final ProductsViewType view;
  final ProductsSortingType sorting;
  final bool showCompleted;
  final bool showMarked;
  final bool ascendingSorting;
  final bool isDefault;

  const ProductsFilter({
    this.view = ProductsViewType.list,
    this.sorting = ProductsSortingType.name,
    this.showCompleted = true,
    this.showMarked = true,
    this.ascendingSorting = true,
    this.isDefault = true,
  });

  @override
  List<Object> get props {
    return [
      view,
      sorting,
      showCompleted,
      showMarked,
      ascendingSorting,
      isDefault,
    ];
  }

  ProductsFilter copyWith({
    ProductsViewType? view,
    ProductsSortingType? sorting,
    bool? showCompleted,
    bool? showMarked,
    bool? ascendingSorting,
    bool? isDefault,
  }) {
    return ProductsFilter(
      view: view ?? this.view,
      sorting: sorting ?? this.sorting,
      showCompleted: showCompleted ?? this.showCompleted,
      showMarked: showMarked ?? this.showMarked,
      ascendingSorting: ascendingSorting ?? this.ascendingSorting,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  String toString() {
    return 'ProductsFilter(view: $view, sorting: $sorting, showCompleted: $showCompleted, showMarked: $showMarked, ascendingSorting: $ascendingSorting, isDefault: $isDefault)';
  }
}
