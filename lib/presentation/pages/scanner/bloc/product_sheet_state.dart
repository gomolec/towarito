part of 'product_sheet_bloc.dart';

enum ProductSheetStatus { loading, found, notFound, failure }

class ProductSheetState extends Equatable {
  final ProductSheetStatus status;
  final String code;
  final Product? product;
  final int quantity;
  final int targetQuantity;
  final bool didChanged;

  const ProductSheetState({
    this.status = ProductSheetStatus.loading,
    this.code = '',
    this.product,
    this.quantity = 0,
    this.targetQuantity = 0,
    this.didChanged = false,
  });

  ProductSheetState copyWith({
    ProductSheetStatus? status,
    String? code,
    Product? Function()? product,
    int? quantity,
    int? targetQuantity,
    bool? didChanged,
  }) {
    return ProductSheetState(
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
    return 'ProductSheetState(status: $status, code: $code, product: $product, quantity: $quantity, targetQuantity: $targetQuantity, didChanged: $didChanged)';
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
