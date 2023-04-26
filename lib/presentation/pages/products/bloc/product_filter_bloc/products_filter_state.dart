part of 'products_filter_bloc.dart';

class ProductsFilterState extends Equatable {
  final ProductsFilter filter;
  final bool isRestarted;

  const ProductsFilterState({
    this.filter = const ProductsFilter(),
    this.isRestarted = false,
  });

  ProductsFilterState copyWith({
    ProductsFilter? filter,
    bool? isRestarted,
  }) {
    return ProductsFilterState(
      filter: filter ?? this.filter,
      isRestarted: isRestarted ?? this.isRestarted,
    );
  }

  @override
  String toString() =>
      'ProductsFilterState(filter: $filter, isRestarted: $isRestarted)';

  @override
  List<Object> get props => [filter, isRestarted];
}
