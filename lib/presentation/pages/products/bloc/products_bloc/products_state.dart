part of 'products_bloc.dart';

enum ProductsStatus { initial, loading, success, failure }

class ProductsState extends Equatable {
  final ProductsStatus status;
  final List<Product> products;
  final ProductsFilter filter;
  final String query;
  final Failure? failure;

  const ProductsState({
    this.status = ProductsStatus.initial,
    this.products = const [],
    this.filter = const ProductsFilter(),
    this.query = "",
    this.failure,
  });

  ProductsState copyWith({
    ProductsStatus? status,
    List<Product>? products,
    ProductsFilter? filter,
    String? query,
    Failure? Function()? failure,
  }) {
    return ProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
      filter: filter ?? this.filter,
      query: query ?? this.query,
      failure: failure != null ? failure() : this.failure,
    );
  }

  @override
  String toString() {
    return 'ProductsState(status: $status, products: $products, filter: $filter, query: $query, failure: $failure)';
  }

  @override
  List<Object?> get props {
    return [
      status,
      products,
      filter,
      query,
      failure,
    ];
  }
}
