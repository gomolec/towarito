part of 'product_bloc.dart';

enum ProductStatus { loading, found, notFound, failure }

class ProductState extends Equatable {
  final ProductStatus status;
  final String code;
  final Product? product;
  final int quantity;
  final int targetQuantity;
  final bool didChanged;

  const ProductState({
    this.status = ProductStatus.loading,
    this.code = '',
    this.product,
    this.quantity = 0,
    this.targetQuantity = 0,
    this.didChanged = false,
  });

  ProductState copyWith({
    ProductStatus? status,
    String? code,
    Product? Function()? product,
    int? quantity,
    int? targetQuantity,
    bool? didChanged,
  }) {
    return ProductState(
      status: status ?? this.status,
      code: code ?? this.code,
      product: product != null ? product() : this.product,
      quantity: quantity ?? this.quantity,
      targetQuantity: targetQuantity ?? this.targetQuantity,
      didChanged: didChanged ?? this.didChanged,
    );
  }

  @override
  String toString() {
    return 'ProductState(status: $status, code: $code, product: $product, quantity: $quantity, targetQuantity: $targetQuantity, didChanged: $didChanged)';
  }

  @override
  List<Object?> get props {
    return [
      status,
      code,
      product,
      quantity,
      targetQuantity,
      didChanged,
    ];
  }
}
