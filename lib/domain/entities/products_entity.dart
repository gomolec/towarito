import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';

class ProductsEntity extends Equatable {
  final List<Product> products;

  const ProductsEntity({
    required this.products,
  });

  ProductsEntity copyWith({
    List<Product>? products,
  }) {
    return ProductsEntity(
      products: products ?? this.products,
    );
  }

  @override
  String toString() => 'ProductsEntity(products: $products)';

  @override
  List<Object> get props => [products];
}
