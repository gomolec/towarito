import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/app/app_scaffold_messager.dart';
import '../../../../core/error/failures.dart';
import '../../../../data/models/models.dart';
import '../../../../domain/adapters/products_adapter.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductsAdapter _productsAdapter;
  final AppScaffoldMessager _appScaffoldMessager;

  ProductBloc({
    required ProductsAdapter productsAdapter,
    required AppScaffoldMessager appScaffoldMessager,
  })  : _productsAdapter = productsAdapter,
        _appScaffoldMessager = appScaffoldMessager,
        super(const ProductState()) {
    on<ProductQueried>(_onQueried);
    on<ProductQuantityChanged>(_onQuantityChanged);
    on<ProductTargetQuantityChanged>(_onTargetQuantityChanged);
    on<ProductChangesSaved>(_onChangesSaved);
    on<ProductBookmarkingChanged>(_onBookmarkingChanged);
  }

  Future<void> _onQueried(
    ProductQueried event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductState(
      status: ProductStatus.loading,
      code: event.code,
    ));
    final result = await _productsAdapter.getProductByCode(code: event.code);
    result.fold(
      (l) {
        if (l is ProductNotFoundFailure) {
          emit(state.copyWith(status: ProductStatus.notFound));
          return;
        }
        emit(state.copyWith(
          status: ProductStatus.failure,
        ));
        _appScaffoldMessager.showSnackbar(message: l.errorMessage);
      },
      (r) {
        emit(state.copyWith(
          status: ProductStatus.found,
          product: () => r,
          quantity: r.quantity,
          targetQuantity: r.targetQuantity,
        ));
      },
    );
  }

  void _onQuantityChanged(
    ProductQuantityChanged event,
    Emitter<ProductState> emit,
  ) {
    if (event.quantity < 0) {
      return;
    }
    emit(state.copyWith(
      quantity: event.quantity,
      didChanged: true,
    ));
  }

  void _onTargetQuantityChanged(
    ProductTargetQuantityChanged event,
    Emitter<ProductState> emit,
  ) {
    emit(state.copyWith(
      targetQuantity: event.targetQuantity,
      didChanged: true,
    ));
  }

  Future<void> _onChangesSaved(
    ProductChangesSaved event,
    Emitter<ProductState> emit,
  ) async {
    if (state.product == null) {
      return;
    }
    if (state.didChanged == false) {
      return;
    }
    emit(state.copyWith(status: ProductStatus.loading));

    final product = state.product!.copyWith(
      quantity: state.quantity,
      targetQuantity: state.targetQuantity,
    );

    final result = await _productsAdapter.updateProduct(product: product);

    result.fold(
      (l) {
        emit(state.copyWith(
          status: ProductStatus.failure,
        ));
        _appScaffoldMessager.showSnackbar(message: l.errorMessage);
      },
      (r) {
        _appScaffoldMessager.showSnackbar(
          message: "Przedmiot został zaaktualizowany",
        );

        emit(state.copyWith(
          product: () => r,
          status: ProductStatus.found,
          quantity: r.quantity,
          targetQuantity: r.targetQuantity,
          didChanged: false,
        ));
      },
    );
  }

  Future<void> _onBookmarkingChanged(
    ProductBookmarkingChanged event,
    Emitter<ProductState> emit,
  ) async {
    if (state.product == null) {
      return;
    }
    emit(state.copyWith(status: ProductStatus.loading));

    final result = await _productsAdapter.updateProduct(
      product: state.product!.copyWith(bookmarked: !state.product!.bookmarked),
    );
    result.fold(
      (l) {
        emit(state.copyWith(
          status: ProductStatus.failure,
        ));
        _appScaffoldMessager.showSnackbar(message: l.errorMessage);
        return;
      },
      (r) {
        emit(state.copyWith(
          product: () => r,
          status: ProductStatus.found,
        ));
      },
    );
  }
}
