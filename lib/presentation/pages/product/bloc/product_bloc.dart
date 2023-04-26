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
    on<ProductSubscriptionRequested>(_onSubscriptionRequested);
    on<ProductQuantityChanged>(_onQuantityChanged);
    on<ProductTargetQuantityChanged>(_onTargetQuantityChanged);
    on<ProductNameChanged>(_onNameChanged);
    on<ProductCodeChanged>(_onCodeChanged);
    on<ProductNoteChanged>(_onNoteChanged);
    on<ProductChangesSaved>(_onChangesSaved);
    on<ProductBookmarkedChanged>(_onBookmarkedChanged);
    on<ProductDeleted>(_onDeleted);
  }

  Future<void> _onSubscriptionRequested(
    ProductSubscriptionRequested event,
    Emitter<ProductState> emit,
  ) async {
    Product? initialProduct;
    emit(state.copyWith(
      status: ProductStatus.loading,
    ));
    if (event.initialProductId != null) {
      final result =
          await _productsAdapter.getProduct(id: event.initialProductId!);
      result.fold(
        (l) {
          emit(state.copyWith(
            status: ProductStatus.failure,
            failure: () => l,
          ));
          _appScaffoldMessager.showSnackbar(message: l.errorMessage);
        },
        (r) => initialProduct = r,
      );
    }
    emit(state.copyWith(
      status: ProductStatus.inProgress,
      initialProduct: initialProduct,
      name: initialProduct?.name,
      code: initialProduct?.code,
      quantity: initialProduct?.quantity,
      targetQuantity: initialProduct?.targetQuantity,
      bookmarked: initialProduct?.bookmarked,
      note: initialProduct?.note,
      didChanged: false,
      failure: () => null,
    ));
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
      status: ProductStatus.inProgress,
    ));
  }

  void _onTargetQuantityChanged(
    ProductTargetQuantityChanged event,
    Emitter<ProductState> emit,
  ) {
    emit(state.copyWith(
      targetQuantity: event.targetQuantity,
      didChanged: true,
      status: ProductStatus.inProgress,
    ));
  }

  void _onNameChanged(
    ProductNameChanged event,
    Emitter<ProductState> emit,
  ) {
    emit(state.copyWith(
      name: event.name,
      didChanged: true,
      status: ProductStatus.inProgress,
    ));
  }

  void _onCodeChanged(
    ProductCodeChanged event,
    Emitter<ProductState> emit,
  ) {
    emit(state.copyWith(
      code: event.code,
      didChanged: true,
      status: ProductStatus.inProgress,
    ));
  }

  void _onNoteChanged(
    ProductNoteChanged event,
    Emitter<ProductState> emit,
  ) {
    emit(state.copyWith(
      note: event.note,
      didChanged: true,
      status: ProductStatus.inProgress,
    ));
  }

  Future<void> _onChangesSaved(
    ProductChangesSaved event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: ProductStatus.loading));

    final product = (state.initialProduct ?? Product()).copyWith(
      name: state.name,
      code: state.code,
      note: state.note,
      quantity: state.quantity,
      targetQuantity: state.targetQuantity,
      bookmarked: state.bookmarked,
    );

    final result = state.isEditing
        ? await _productsAdapter.updateProduct(product: product)
        : await _productsAdapter.createProduct(product: product);

    result.fold(
      (l) {
        emit(state.copyWith(
          status: ProductStatus.failure,
          failure: () => l,
        ));
        _appScaffoldMessager.showSnackbar(message: l.errorMessage);
      },
      (r) {
        _appScaffoldMessager.showSnackbar(
          message: state.isEditing
              ? "Przedmiot został zaaktualizowany"
              : "Przedmiot został dodany",
        );
        add(ProductSubscriptionRequested(initialProductId: product.id));
      },
    );
  }

  Future<void> _onBookmarkedChanged(
    ProductBookmarkedChanged event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: ProductStatus.loading));

    if (state.isEditing) {
      final result = await _productsAdapter.updateProduct(
        product: state.initialProduct!.copyWith(bookmarked: event.bookmarked),
      );
      result.fold(
        (l) {
          emit(state.copyWith(
            status: ProductStatus.failure,
            failure: () => l,
          ));
          _appScaffoldMessager.showSnackbar(message: l.errorMessage);
          return;
        },
        (r) {},
      );
    }
    emit(state.copyWith(
      bookmarked: event.bookmarked,
      status: ProductStatus.inProgress,
    ));
  }

  Future<void> _onDeleted(
    ProductDeleted event,
    Emitter<ProductState> emit,
  ) async {
    if (state.isEditing) {
      final result = await _productsAdapter.deleteProduct(
        id: state.initialProduct!.id,
      );
      result.fold(
        (l) {
          emit(state.copyWith(
            status: ProductStatus.failure,
            failure: () => l,
          ));
          _appScaffoldMessager.showSnackbar(message: l.errorMessage);
          return;
        },
        (r) {},
      );
    }
    emit(state.copyWith(
      status: ProductStatus.success,
    ));
    _appScaffoldMessager.showSnackbar(message: "Przedmiot został usunięty");
  }
}
