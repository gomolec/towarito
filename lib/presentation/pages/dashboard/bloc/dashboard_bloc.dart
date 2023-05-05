import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/app/app_scaffold_messager.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/extensions/either_extension.dart';
import '../../../../data/models/models.dart';
import '../../../../domain/adapters/products_adapter.dart';
import '../../../../domain/adapters/sessions_adapter.dart';
import '../../../../domain/entities/products_entity.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final ProductsAdapter _productsAdapter;
  final SessionsAdapter _sessionsAdapter;
  final AppScaffoldMessager _appScaffoldMessager;

  DashboardBloc({
    required ProductsAdapter productsAdapter,
    required SessionsAdapter sessionsAdapter,
    required AppScaffoldMessager appScaffoldMessager,
  })  : _productsAdapter = productsAdapter,
        _sessionsAdapter = sessionsAdapter,
        _appScaffoldMessager = appScaffoldMessager,
        super(const DashboardState()) {
    on<DashboardSubscriptionRequested>(_subscriptionRequested);
  }

  int _sessionProgress = 0;
  List<Product> _bookmarkedProducts = [];

  Future<void> _subscriptionRequested(
    DashboardSubscriptionRequested event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(status: DashboardStatus.loading));

    await emit.onEach<ProductsEntity>(
      _productsAdapter.observeProductsData(),
      onData: (data) async {
        if (!data.isSessionOpened) {
          emit(state.copyWith(
            status: DashboardStatus.success,
            currentSession: () => null,
            sessionProgress: 0,
            bookmarkedProducts: const [],
          ));
          return;
        }
        getProductsData(data.products!);
        if (state.hasCurrentSession) {
          emit(state.copyWith(
            status: DashboardStatus.success,
            sessionProgress: _sessionProgress,
            bookmarkedProducts: _bookmarkedProducts,
          ));
          return;
        }
        emit(state.copyWith(status: DashboardStatus.loading));
        final currentSessionResult = await _sessionsAdapter.getCurrentSession();
        if (currentSessionResult.isLeft()) {
          emit(state.copyWith(
            status: DashboardStatus.failure,
            failure: () => currentSessionResult.asLeft(),
          ));
          _appScaffoldMessager.showSnackbar(
              message: currentSessionResult.asLeft().errorMessage);
          return;
        }
        emit(state.copyWith(
          status: DashboardStatus.success,
          currentSession: () => currentSessionResult.asRight(),
          sessionProgress: _sessionProgress,
          bookmarkedProducts: _bookmarkedProducts,
        ));
      },
    );
  }

  void getProductsData(List<Product> products) {
    _bookmarkedProducts = [];
    if (products.isEmpty) {
      _sessionProgress = 0;
      return;
    }
    int finishedProducts = 0;
    for (var product in products) {
      if (product.quantity >= product.targetQuantity) {
        finishedProducts++;
      }
      if (product.bookmarked) {
        _bookmarkedProducts.add(product);
      }
    }
    _sessionProgress = (finishedProducts / products.length * 100).round();
    _bookmarkedProducts.sort((a, b) => a.updated.compareTo(b.updated));
    _bookmarkedProducts = _bookmarkedProducts.reversed.toList();
  }
}
