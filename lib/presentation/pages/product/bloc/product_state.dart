part of 'product_bloc.dart';

enum ProductStatus { initial, loading, inProgress, success, failure }

extension ProductStatusX on ProductStatus {
  bool get canViewForm {
    if (this == ProductStatus.inProgress || this == ProductStatus.failure) {
      return true;
    }
    return false;
  }
}

class ProductState extends Equatable {
  final ProductStatus status;
  final Product? initialProduct;
  final String name;
  final String code;
  final int quantity;
  final int targetQuantity;
  final bool bookmarked;
  final String note;
  final bool didChanged;
  final Failure? failure;

  const ProductState(
      {this.status = ProductStatus.initial,
      this.initialProduct,
      this.name = "",
      this.code = "",
      this.quantity = 0,
      this.targetQuantity = 0,
      this.bookmarked = false,
      this.note = "",
      this.didChanged = false,
      this.failure});

  bool get isEditing => initialProduct != null;

  @override
  List<Object?> get props {
    return [
      status,
      initialProduct,
      name,
      code,
      quantity,
      targetQuantity,
      bookmarked,
      note,
      didChanged,
      failure,
    ];
  }

  @override
  String toString() {
    return 'ProductState(status: $status, initialProduct: $initialProduct, name: $name, code: $code, quantity: $quantity, targetQuantity: $targetQuantity, bookmarked: $bookmarked, note_len: ${note.length}, didChanged: $didChanged, failure: $failure)';
  }

  ProductState copyWith({
    ProductStatus? status,
    Product? initialProduct,
    String? name,
    String? code,
    int? quantity,
    int? targetQuantity,
    bool? bookmarked,
    String? note,
    bool? didChanged,
    Failure? Function()? failure,
  }) {
    return ProductState(
      status: status ?? this.status,
      initialProduct: initialProduct ?? this.initialProduct,
      name: name ?? this.name,
      code: code ?? this.code,
      quantity: quantity ?? this.quantity,
      targetQuantity: targetQuantity ?? this.targetQuantity,
      bookmarked: bookmarked ?? this.bookmarked,
      note: note ?? this.note,
      didChanged: didChanged ?? this.didChanged,
      failure: failure != null ? failure() : this.failure,
    );
  }
}
