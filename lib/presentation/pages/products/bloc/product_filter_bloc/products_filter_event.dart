part of 'products_filter_bloc.dart';

abstract class ProductsFilterEvent extends Equatable {
  const ProductsFilterEvent();

  @override
  List<Object?> get props => [];
}

class FilterChangeView extends ProductsFilterEvent {
  final ProductsViewType view;

  const FilterChangeView(
    this.view,
  );

  @override
  List<Object> get props => [view];
}

class FilterChangeSorting extends ProductsFilterEvent {
  final ProductsSortingType sorting;
  final bool? ascending;

  const FilterChangeSorting(
    this.sorting, {
    this.ascending,
  });

  @override
  List<Object?> get props => [sorting, ascending];
}

class FilterShowCompleted extends ProductsFilterEvent {
  final bool show;

  const FilterShowCompleted(
    this.show,
  );

  @override
  List<Object> get props => [show];
}

class FilterShowMarked extends ProductsFilterEvent {
  final bool show;

  const FilterShowMarked(
    this.show,
  );

  @override
  List<Object> get props => [show];
}

class FilterReset extends ProductsFilterEvent {
  const FilterReset();
}
