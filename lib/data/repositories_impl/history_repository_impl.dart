import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/constants/constants.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/history_entity.dart';
import '../../domain/repositories/history_repository.dart';
import '../datasources/history_local_datasource.dart';
import '../models/history_action_model.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryLocalDatasource _source;

  HistoryRepositoryImpl({
    required HistoryLocalDatasource source,
  }) : _source = source;

  final _historyStreamController = BehaviorSubject<HistoryEntity>.seeded(
    const HistoryEntity(),
  );

  @override
  Future<Either<Failure, None>> addAction(
      {required HistoryAction action}) async {
    try {
      final history = _source.getHistory();
      if (history == null) {
        await _source.saveAction(action);
        _refreshHistoryStreamData();
        return const Right(None());
      }
      final currentHistoryIndex = _currentHistoryAction(history) + 1;
      if (history.length > currentHistoryIndex) {
        for (var i = history.length - 1; i >= currentHistoryIndex; i--) {
          await _source.deleteHistoryAction(history[i].id);
        }
      }
      if (currentHistoryIndex >= kMaxStoredHistoryActions) {
        await _source.deleteHistoryAction(history.first.id);
      }
      await _source.saveAction(action);
      _refreshHistoryStreamData();
      return const Right(None());
    } catch (e) {
      return Left(CreateProductFailure('$e [id: $id]'));
    }
  }

  @override
  Future<Either<Failure, None>> closeSession() async {
    try {
      await _source.closeSession();
      _refreshHistoryStreamData();
      return const Right(None());
    } catch (e) {
      return Left(CloseProductsSessionFailure('$e [id: $id]'));
    }
  }

  @override
  Stream<HistoryEntity> observeHistoryData() => _historyStreamController.stream;

  @override
  Future<Either<Failure, None>> openSession({required String id}) async {
    try {
      await _source.openSession(id);
      _refreshHistoryStreamData();
      return const Right(None());
    } catch (e) {
      return Left(OpenProductsSessionFailure('$e [id: $id]'));
    }
  }

  @override
  Future<Either<Failure, HistoryAction>> redoAction() async {
    try {
      final history = _source.getHistory();
      if (history == null || history.isEmpty || history.first.isRedo == false) {
        return const Left(HistoryRedoFailure("Brak historii do ponawiania"));
      }
      final action = await _source.saveAction(
          history[_currentHistoryAction(history) + 1].copyWith(isRedo: false));
      _refreshHistoryStreamData();
      return Right(action);
    } catch (e) {
      return Left(HistoryRedoFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, HistoryAction>> undoAction() async {
    try {
      final history = _source.getHistory();
      if (history == null || history.isEmpty || history.first.isRedo == true) {
        return const Left(HistoryUndoFailure("Brak historii do cofania"));
      }
      final action = await _source.saveAction(
          history[_currentHistoryAction(history)].copyWith(isRedo: true));
      _refreshHistoryStreamData();
      return Right(action);
    } catch (e) {
      return Left(HistoryUndoFailure(e.toString()));
    }
  }

  void _refreshHistoryStreamData() {
    late final HistoryEntity data;
    final history = _source.getHistory();
    if (history == null) {
      data = const HistoryEntity();
    }
    if (history!.isEmpty) {
      data = HistoryEntity(history: history);
    }
    data = HistoryEntity(
      history: history,
      canUndo: history.first.isRedo == false,
      canRedo: history.last.isRedo == true,
    );

    _historyStreamController.add(data);
  }

  void dispose() {
    _historyStreamController.close();
  }

  int _currentHistoryAction(List<HistoryAction> history) {
    return history.lastIndexWhere((e) => e.isRedo == false);
  }
}
