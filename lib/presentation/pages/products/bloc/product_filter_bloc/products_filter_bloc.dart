import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../data/models/products_filter_model.dart';

part 'products_filter_event.dart';
part 'products_filter_state.dart';

class ProductsFilterBloc
    extends Bloc<ProductsFilterEvent, ProductsFilterState> {
  final ProductsFilter _initialFilter;
  ProductsFilterBloc({
    required ProductsFilter initialFilter,
  })  : _initialFilter = initialFilter,
        super(ProductsFilterState(
          filter: initialFilter,
        )) {
    on<FilterChangeView>(_onFilterChangeView);
    on<FilterChangeSorting>(_onFilterChangeSorting);
    on<FilterShowCompleted>(_onFilterShowCompleted);
    on<FilterShowMarked>(_onFilterShowMarked);
    on<FilterReset>(_onFilterReset);
  }

  void _onFilterChangeView(
    FilterChangeView event,
    Emitter<ProductsFilterState> emit,
  ) {
    final newFilter = state.filter.copyWith(
      view: event.view,
    );
    emit(state.copyWith(
      filter: newFilter.copyWith(
        isDefault: newFilter == _initialFilter,
      ),
    ));
  }

  void _onFilterChangeSorting(
    FilterChangeSorting event,
    Emitter<ProductsFilterState> emit,
  ) {
    final newFilter = state.filter.copyWith(
      sorting: event.sorting,
      ascendingSorting: event.ascending,
    );
    emit(state.copyWith(
      filter: newFilter.copyWith(
        isDefault: newFilter == _initialFilter,
      ),
    ));
  }

  void _onFilterShowCompleted(
    FilterShowCompleted event,
    Emitter<ProductsFilterState> emit,
  ) {
    final newFilter = state.filter.copyWith(
      showCompleted: event.show,
    );
    emit(state.copyWith(
      filter: newFilter.copyWith(
        isDefault: newFilter == _initialFilter,
      ),
    ));
  }

  void _onFilterShowMarked(
    FilterShowMarked event,
    Emitter<ProductsFilterState> emit,
  ) {
    final newFilter = state.filter.copyWith(
      showMarked: event.show,
    );
    emit(state.copyWith(
      filter: newFilter.copyWith(
        isDefault: newFilter == _initialFilter,
      ),
    ));
  }

  void _onFilterReset(
    FilterReset event,
    Emitter<ProductsFilterState> emit,
  ) {
    emit(state.copyWith(
      filter: const ProductsFilter(),
      isRestarted: true,
    ));
  }
}
