import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../../../../../core/app/app_scaffold_messager.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/utilities/products_querier.dart';
import '../../../../../core/utilities/products_sorter.dart';
import '../../../../../data/models/models.dart';
import '../../../../../domain/adapters/products_adapter.dart';
import '../../../../../domain/entities/products_entity.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsAdapter _productsAdapter;
  final AppScaffoldMessager _appScaffoldMessager;
  final ProductsQuerier _querier = const ProductsQuerier();
  final ProductsSorter _sorter = const ProductsSorter();

  EventTransformer<E> throttleDroppable<E>(Duration duration) {
    return (events, mapper) {
      return droppable<E>().call(events.throttle(duration), mapper);
    };
  }

  ProductsBloc({
    required ProductsAdapter productsAdapter,
    required AppScaffoldMessager appScaffoldMessager,
  })  : _productsAdapter = productsAdapter,
        _appScaffoldMessager = appScaffoldMessager,
        super(const ProductsState()) {
    on<ProductsSubscriptionRequested>(_onSubscriptionRequested);
    on<ProductDeleted>(_onProductDeleted);
    on<ProductBookmarkingToggled>(_onProductMarkingToggled);
    on<ProductsAppliedFilter>(_onProductsAppliedFilter);
    on<ProductsQueried>(_onProductsQueried);
    on<ProductsFetched>(
      _onProductsFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  static const _paginationLimit = 20;
  static const throttleDuration = Duration(milliseconds: 100);

  List<Product> _products = [];
  List<Product> _sortedProducts = [];

  Future<void> _onSubscriptionRequested(
    ProductsSubscriptionRequested event,
    Emitter<ProductsState> emit,
  ) async {
    emit(state.copyWith(status: ProductsStatus.loading));
    await emit.onEach<ProductsEntity>(
      _productsAdapter.observeProductsData(),
      onData: (data) {
        if (data.isSessionOpened) {
          _products = List.of(data.products!);
          emit(state.copyWith(
            status: ProductsStatus.success,
            products: getProcessedProducts(
              products: _products,
              query: state.query,
              filter: state.filter,
            ),
            shouldReturnToTop: false,
            hasReachedMax: _sortedProducts.length <= _paginationLimit,
          ));
          return;
        }
        _products = List.empty();
        _sortedProducts = List.empty();
        emit(state.copyWith(
          status: ProductsStatus.initial,
          products: _products,
          filter: const ProductsFilter(),
          query: "",
          hasReachedMax: true,
          shouldReturnToTop: true,
        ));
      },
      onError: (error, stackTrace) {
        emit(state.copyWith(
          status: ProductsStatus.failure,
          failure: () => UnnamedFailure(error.toString()),
        ));
        _appScaffoldMessager.showSnackbar(message: error.toString());
      },
    );
  }

  Future<void> _onProductDeleted(
    ProductDeleted event,
    Emitter<ProductsState> emit,
  ) async {
    final result = await _productsAdapter.deleteProduct(id: event.id);
    emitEitherResult(emit, result);
  }

  Future<void> _onProductMarkingToggled(
    ProductBookmarkingToggled event,
    Emitter<ProductsState> emit,
  ) async {
    final result = await _productsAdapter.updateProduct(
      product: event.product.copyWith(
        bookmarked: !event.product.bookmarked,
      ),
    );
    emitEitherResult(
      emit,
      result,
      snackbarSuccessMessage: event.product.bookmarked
          ? "Przedmiot został usunięty z zapisanych"
          : "Przedmiot został dodany do zapisanych",
    );
  }

  void _onProductsAppliedFilter(
    ProductsAppliedFilter event,
    Emitter<ProductsState> emit,
  ) {
    emit(state.copyWith(
      products: getProcessedProducts(
        products: _products,
        query: state.query,
        filter: event.filter,
      ),
      filter: event.filter,
      hasReachedMax: _sortedProducts.length <= _paginationLimit,
      shouldReturnToTop: true,
    ));
  }

  void _onProductsQueried(
    ProductsQueried event,
    Emitter<ProductsState> emit,
  ) {
    emit(state.copyWith(
      products: getProcessedProducts(
        products: _products,
        query: event.query,
        filter: state.filter,
      ),
      query: event.query,
      hasReachedMax: _sortedProducts.length <= _paginationLimit,
      shouldReturnToTop: true,
    ));
  }

  void _onProductsFetched(
    ProductsFetched event,
    Emitter<ProductsState> emit,
  ) {
    if (state.hasReachedMax) return;
    final hasReachedMax =
        state.products.length + _paginationLimit >= _sortedProducts.length;
    emit(state.copyWith(
      hasReachedMax: hasReachedMax,
      shouldReturnToTop: false,
      products: _sortedProducts
          .getRange(
              0,
              hasReachedMax
                  ? _sortedProducts.length
                  : state.products.length + _paginationLimit)
          .toList(),
    ));
  }

  void emitEitherResult(
    Emitter<ProductsState> emit,
    Either<Failure, dynamic> result, {
    String? snackbarSuccessMessage,
  }) {
    result.fold(
      (l) {
        emit(state.copyWith(
          status: ProductsStatus.failure,
          shouldReturnToTop: true,
          failure: () => l,
        ));
        _appScaffoldMessager.showSnackbar(message: l.errorMessage);
      },
      (r) {
        emit(state.copyWith(
          status: ProductsStatus.success,
          shouldReturnToTop: false,
          failure: () => null,
        ));
        if (snackbarSuccessMessage != null) {
          _appScaffoldMessager.showSnackbar(message: snackbarSuccessMessage);
        }
      },
    );
  }

  List<Product> getProcessedProducts({
    required List<Product> products,
    required String query,
    required ProductsFilter filter,
  }) {
    _sortedProducts = _sorter.sortProducts(
      products: _querier.query(
        products,
        query,
      ),
      filter: filter,
    );
    return _sortedProducts
        .getRange(
          0,
          _sortedProducts.length < _paginationLimit
              ? _sortedProducts.length
              : _paginationLimit,
        )
        .toList();
  }
}
