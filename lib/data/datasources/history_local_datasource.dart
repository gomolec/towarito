import 'package:hive_flutter/hive_flutter.dart';

import '../../core/constants/constants.dart';
import '../../core/error/exceptions.dart';
import '../models/history_action_model.dart';

abstract class HistoryLocalDatasource {
  /// Open history session with given [Id]
  ///
  /// If such a session does not exist, it creates one.
  Future<void> openSession(String id);

  /// Close history session;
  ///
  /// If no session is open, nothing happens
  Future<void> closeSession();

  /// Returns a nullable [List] of all history actions.
  ///
  /// Null is returned when session is not opened.
  List<HistoryAction>? getHistory();

  /// Saves and returns a [HistoryAction].
  ///
  /// If a [HistoryAction] with the same id already exists, it will be replaced.
  Future<HistoryAction> saveAction(HistoryAction action);

  /// Deletes and returns the [HistoryAction] with the given id.
  ///
  /// If no product with the given id exists, nothing happens.
  Future<HistoryAction> deleteHistoryAction(String id);

  /// Returns a single [HistoryAction] with the given id.
  ///
  /// If no product with the given id exists, a [HistoryActionNotFoundException] error is
  /// thrown.
  HistoryAction getSingleAction(String id);
}

class HistoryLocalDatasourceImpl implements HistoryLocalDatasource {
  final HiveInterface _datasource;

  HistoryLocalDatasourceImpl({
    required HiveInterface datasource,
  }) : _datasource = datasource;

  Box<HistoryAction>? _historySource;

  @override
  Future<void> closeSession() async {
    if (_historySource != null) {
      _historySource!.close();
      _historySource = null;
    }
  }

  @override
  Future<HistoryAction> deleteHistoryAction(String id) async {
    final action = getSingleAction(id);

    await _historySource!.delete(action.id);

    return action;
  }

  @override
  List<HistoryAction>? getHistory() {
    if (_historySource != null) {
      return _historySource!.values.toList();
    }
    return null;
  }

  @override
  Future<void> openSession(String id) async {
    closeSession();
    _historySource =
        await _datasource.openBox<HistoryAction>('$kHistoryBoxName$id');
  }

  @override
  Future<HistoryAction> saveAction(HistoryAction action) async {
    if (_historySource == null) {
      throw HistorySessionNotOpenedException();
    }
    _historySource!.put(action.id, action);
    return action;
  }

  @override
  HistoryAction getSingleAction(String id) {
    if (_historySource == null) {
      throw ProductsSessionNotOpenedException();
    }
    final action = _historySource!.get(id);

    if (action == null) {
      throw HistoryActionNotFoundException();
    }

    return action;
  }
}
