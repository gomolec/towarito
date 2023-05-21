import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/app/app_scaffold_messager.dart';
import '../../../../core/error/failures.dart';
import '../../../../data/models/models.dart';
import '../../../../domain/adapters/products_adapter.dart';

part 'product_sheet_event.dart';
part 'product_sheet_state.dart';

class ProductSheetBloc extends Bloc<ProductSheetEvent, ProductSheetState> {
  final ProductsAdapter _productsAdapter;
  final AppScaffoldMessager _appScaffoldMessager;

  ProductSheetBloc({
    required ProductsAdapter productsAdapter,
    required AppScaffoldMessager appScaffoldMessager,
  })  : _productsAdapter = productsAdapter,
        _appScaffoldMessager = appScaffoldMessager,
        super(const ProductSheetState()) {
    //on<ProductSheetSubscriptionRequested>(_onSubscriptionRequested);
    on<ProductSheetQueried>(_onQueried);
    on<ProductSheetQuantityChanged>(_onQuantityChanged);
    on<ProductSheetTargetQuantityChanged>(_onTargetQuantityChanged);
    on<ProductSheetChangesSaved>(_onChangesSaved);
    on<ProductSheetBookmarkingChanged>(_onBookmarkingChanged);
  }

  // Future<void> _onSubscriptionRequested(
  //   ProductSheetSubscriptionRequested event,
  //   Emitter<ProductSheetState> emit,
  // ) async {
  //   await emit.onEach(
  //     _productsAdapter.observeProductsData(),
  //     onData: (data) {
  //       log("OTRZYMUJE ZMIANE !!!!");
  //       if (state.product == null) {
  //         return;
  //       }
  //       emit(state.copyWith(status: ProductSheetStatus.loading));
  //       _onQueried(ProductSheetQueried(state.code), emit);
  //     },
  //     onError: (error, stackTrace) {
  //       emit(state.copyWith(
  //         status: ProductSheetStatus.failure,
  //       ));
  //       _appScaffoldMessager.showSnackbar(message: error.toString());
  //     },
  //   );
  // }

  Future<void> _onQueried(
    ProductSheetQueried event,
    Emitter<ProductSheetState> emit,
  ) async {
    final result = await _productsAdapter.getProductByCode(code: event.code);
    result.fold(
      (l) {
        if (l is ProductNotFoundFailure) {
          emit(state.copyWith(
            status: ProductSheetStatus.notFound,
            code: event.code,
          ));
          return;
        }
        emit(state.copyWith(
          status: ProductSheetStatus.failure,
          code: event.code,
        ));
        _appScaffoldMessager.showSnackbar(message: l.errorMessage);
      },
      (r) {
        emit(state.copyWith(
          status: ProductSheetStatus.found,
          code: event.code,
          product: () => r,
          quantity: r.quantity,
          targetQuantity: r.targetQuantity,
        ));
      },
    );
  }

  void _onQuantityChanged(
    ProductSheetQuantityChanged event,
    Emitter<ProductSheetState> emit,
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
    ProductSheetTargetQuantityChanged event,
    Emitter<ProductSheetState> emit,
  ) {
    emit(state.copyWith(
      targetQuantity: event.targetQuantity,
      didChanged: true,
    ));
  }

  Future<void> _onChangesSaved(
    ProductSheetChangesSaved event,
    Emitter<ProductSheetState> emit,
  ) async {
    if (state.product == null || state.didChanged == false) {
      return;
    }
    emit(state.copyWith(status: ProductSheetStatus.loading));

    final product = state.product!.copyWith(
      quantity: state.quantity,
      targetQuantity: state.targetQuantity,
    );

    final result = await _productsAdapter.updateProduct(product: product);

    result.fold(
      (l) {
        emit(state.copyWith(
          status: ProductSheetStatus.failure,
        ));
        _appScaffoldMessager.showSnackbar(message: l.errorMessage);
      },
      (r) {
        _appScaffoldMessager.showSnackbar(
          message: "Przedmiot został zaaktualizowany",
        );

        emit(state.copyWith(
          product: () => r,
          status: ProductSheetStatus.found,
          quantity: r.quantity,
          targetQuantity: r.targetQuantity,
          didChanged: false,
        ));
      },
    );
  }

  Future<void> _onBookmarkingChanged(
    ProductSheetBookmarkingChanged event,
    Emitter<ProductSheetState> emit,
  ) async {
    if (state.product == null) {
      return;
    }
    emit(state.copyWith(status: ProductSheetStatus.loading));

    final result = await _productsAdapter.updateProduct(
      product: state.product!.copyWith(bookmarked: !state.product!.bookmarked),
    );
    result.fold(
      (l) {
        emit(state.copyWith(
          status: ProductSheetStatus.failure,
        ));
        _appScaffoldMessager.showSnackbar(message: l.errorMessage);
        return;
      },
      (r) {
        emit(state.copyWith(
          product: () => r,
          status: ProductSheetStatus.found,
        ));
      },
    );
  }
}
