part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class ProductsSubscriptionRequested extends ProductsEvent {
  const ProductsSubscriptionRequested();
}

class ProductDeleted extends ProductsEvent {
  final String id;

  const ProductDeleted({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class ProductBookmarkingToggled extends ProductsEvent {
  final Product product;

  const ProductBookmarkingToggled({
    required this.product,
  });

  @override
  List<Object> get props => [product];
}

class ProductsAppliedFilter extends ProductsEvent {
  final ProductsFilter filter;

  const ProductsAppliedFilter(
    this.filter,
  );

  @override
  List<Object> get props => [filter];
}

class ProductsQueried extends ProductsEvent {
  final String query;

  const ProductsQueried(
    this.query,
  );

  @override
  List<Object> get props => [query];
}
