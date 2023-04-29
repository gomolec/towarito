import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:towarito/core/error/failures.dart';
import 'package:towarito/core/utilities/products_querier.dart';
import 'package:towarito/core/utilities/products_sorter.dart';
import 'package:towarito/domain/adapters/products_adapter.dart';

import '../../../../../core/app/app_scaffold_messager.dart';
import '../../../../../data/models/models.dart';
import '../../../../../domain/entities/products_entity.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsAdapter _productsAdapter;
  final AppScaffoldMessager _appScaffoldMessager;
  final ProductsQuerier _querier = const ProductsQuerier();
  final ProductsSorter _sorter = const ProductsSorter();

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
  }

  List<Product> _products = [];

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
          ));
          return;
        }
        _products = List.empty();
        emit(state.copyWith(
          status: ProductsStatus.initial,
          products: _products,
          filter: const ProductsFilter(),
          query: "",
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
      snackbarSuccessMessage: "Przedmiot został usunięty",
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
          failure: () => l,
        ));
        _appScaffoldMessager.showSnackbar(message: l.errorMessage);
      },
      (r) {
        emit(state.copyWith(
          status: ProductsStatus.success,
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
    return _sorter.sortProducts(
      products: _querier.query(
        products,
        query,
      ),
      filter: filter,
    );
  }
}
