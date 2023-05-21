part of 'product_sheet_bloc.dart';

abstract class ProductSheetEvent extends Equatable {
  const ProductSheetEvent();

  @override
  List<Object> get props => [];
}

class ProductSheetSubscriptionRequested extends ProductSheetEvent {
  const ProductSheetSubscriptionRequested();
}

class ProductSheetQueried extends ProductSheetEvent {
  final String code;

  const ProductSheetQueried(this.code);

  @override
  List<Object> get props => [code];
}

class ProductSheetQuantityChanged extends ProductSheetEvent {
  final int quantity;

  const ProductSheetQuantityChanged(this.quantity);

  @override
  List<Object> get props => [quantity];
}

class ProductSheetTargetQuantityChanged extends ProductSheetEvent {
  final int targetQuantity;

  const ProductSheetTargetQuantityChanged(this.targetQuantity);

  @override
  List<Object> get props => [targetQuantity];
}

class ProductSheetChangesSaved extends ProductSheetEvent {
  const ProductSheetChangesSaved();
}

class ProductSheetBookmarkingChanged extends ProductSheetEvent {
  const ProductSheetBookmarkingChanged();
}
