part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductQueried extends ProductEvent {
  final String code;

  const ProductQueried(this.code);

  @override
  List<Object> get props => [code];
}

class ProductQuantityChanged extends ProductEvent {
  final int quantity;

  const ProductQuantityChanged(this.quantity);

  @override
  List<Object> get props => [quantity];
}

class ProductTargetQuantityChanged extends ProductEvent {
  final int targetQuantity;

  const ProductTargetQuantityChanged(this.targetQuantity);

  @override
  List<Object> get props => [targetQuantity];
}

class ProductChangesSaved extends ProductEvent {
  const ProductChangesSaved();
}

class ProductBookmarkingChanged extends ProductEvent {
  const ProductBookmarkingChanged();
}
