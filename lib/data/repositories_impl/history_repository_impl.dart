import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/constants/constants.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/history_entity.dart';
import '../../domain/repositories/history_repository.dart';
import '../datasources/history_local_datasource.dart';
import '../models/models.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryLocalDatasource _source;

  HistoryRepositoryImpl({
    required HistoryLocalDatasource source,
  }) : _source = source;

  final _historyStreamController = BehaviorSubject<HistoryEntity>.seeded(
    const HistoryEntity(),
  );

  @override
  Future<Either<Failure, None>> addAction({
    Product? oldProduct,
    Product? updatedProduct,
  }) async {
    try {
      final history = _source.getHistory();
      if (history == null || history.isEmpty) {
        await _source.saveAction(HistoryAction(
          id: 0,
          oldProduct: oldProduct,
          updatedProduct: updatedProduct,
        ));
        _refreshHistoryStreamData();
        return const Right(None());
      }
      final currentHistoryIndex = _currentHistoryActionIndex(history);
      if (history.length > currentHistoryIndex) {
        for (var i = history.length - 1; i >= currentHistoryIndex + 1; i--) {
          await _source.deleteHistoryAction(history[i].id);
        }
      }
      if (currentHistoryIndex + 1 >= kMaxStoredHistoryActions) {
        await _source.deleteHistoryAction(history.first.id);
      }
      await _source.saveAction(HistoryAction(
        id: currentHistoryIndex + 1,
        oldProduct: oldProduct,
        updatedProduct: updatedProduct,
      ));
      _refreshHistoryStreamData();
      return const Right(None());
    } catch (e) {
      return Left(CreateHistoryActionFailure('$e'));
    }
  }

  @override
  Future<Either<Failure, None>> closeSession() async {
    try {
      await _source.closeSession();
      _refreshHistoryStreamData();
      return const Right(None());
    } catch (e) {
      return Left(CloseHistorySessionFailure('$e'));
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
      return Left(OpenHistorySessionFailure('$e [id: $id]'));
    }
  }

  @override
  Future<Either<Failure, HistoryAction>> redoAction() async {
    try {
      final history = _source.getHistory();
      if (history == null || history.isEmpty || history.last.isRedo == false) {
        return const Left(HistoryRedoFailure("Brak historii do ponawiania"));
      }
      final action = await _source.saveAction(
          history[_currentHistoryActionIndex(history) + 1]
              .copyWith(isRedo: false));
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
          history[_currentHistoryActionIndex(history)].copyWith(isRedo: true));
      _refreshHistoryStreamData();
      return Right(action);
    } catch (e) {
      return Left(HistoryUndoFailure(e.toString()));
    }
  }

  void _refreshHistoryStreamData() {
    final history = _source.getHistory();
    if (history == null) {
      _historyStreamController.add(const HistoryEntity());
      return;
    }
    if (history.isEmpty) {
      _historyStreamController.add(HistoryEntity(history: history));
      return;
    }
    _historyStreamController.add(HistoryEntity(
      history: history,
      canUndo: history.first.isRedo == false,
      canRedo: history.last.isRedo == true,
    ));
  }

  void dispose() {
    _historyStreamController.close();
  }

  int _currentHistoryActionIndex(List<HistoryAction> history) {
    return history.lastIndexWhere((e) => e.isRedo == false);
  }
}
