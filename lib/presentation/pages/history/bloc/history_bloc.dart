import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/app/app_scaffold_messager.dart';
import '../../../../core/error/failures.dart';
import '../../../../data/models/models.dart';
import '../../../../domain/adapters/history_adapter.dart';
import '../../../../domain/entities/history_entity.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryAdapter _historyAdapter;
  final AppScaffoldMessager _appScaffoldMessager;

  HistoryBloc({
    required HistoryAdapter historyAdapter,
    required AppScaffoldMessager appScaffoldMessager,
  })  : _historyAdapter = historyAdapter,
        _appScaffoldMessager = appScaffoldMessager,
        super(const HistoryState()) {
    on<HistorySubscriptionRequested>(_onSubscriptionRequested);
    on<HistoryUndone>(_onUndone);
    on<HistoryRedone>(_onRedone);
  }

  Future<void> _onSubscriptionRequested(
    HistorySubscriptionRequested event,
    Emitter<HistoryState> emit,
  ) async {
    emit(state.copyWith(status: HistoryStatus.loading));
    await emit.onEach<HistoryEntity>(
      _historyAdapter.observeHistoryData(),
      onData: (data) {
        if (data.isSessionOpened) {
          emit(state.copyWith(
            status: HistoryStatus.success,
            history: data.history!.reversed
                .where((element) => element.isRedo == false)
                .toList(),
            canUndo: data.canUndo,
            canRedo: data.canRedo,
          ));
          return;
        }
        emit(state.copyWith(
          status: HistoryStatus.initial,
          history: List.empty(),
          canUndo: data.canUndo,
          canRedo: data.canRedo,
        ));
      },
      onError: (error, stackTrace) {
        emit(state.copyWith(
          failure: () => UnnamedFailure(error.toString()),
        ));
        _appScaffoldMessager.showSnackbar(message: error.toString());
      },
    );
  }

  Future<void> _onUndone(
    HistoryUndone event,
    Emitter<HistoryState> emit,
  ) async {
    final result = await _historyAdapter.undo();
    result.fold(
      (l) {
        emit(state.copyWith(
          failure: () => l,
        ));
        _appScaffoldMessager.showSnackbar(message: l.errorMessage);
      },
      (r) {
        emit(state.copyWith(
          failure: () => null,
        ));
      },
    );
  }

  Future<void> _onRedone(
    HistoryRedone event,
    Emitter<HistoryState> emit,
  ) async {
    final result = await _historyAdapter.redo();
    result.fold(
      (l) {
        emit(state.copyWith(
          failure: () => l,
        ));
        _appScaffoldMessager.showSnackbar(message: l.errorMessage);
      },
      (r) {
        emit(state.copyWith(
          failure: () => null,
        ));
      },
    );
  }
}
