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
  /// If no action with the given id exists, a [HistoryActionNotFoundException]
  /// error is thrown.
  Future<HistoryAction> deleteHistoryAction(int id);

  /// Returns a single [HistoryAction] with the given id.
  ///
  /// If no action with the given id exists, a [HistoryActionNotFoundException]
  /// error is thrown.
  HistoryAction getSingleAction(int id);
}

class HistoryLocalDatasourceImpl implements HistoryLocalDatasource {
  final HiveInterface _datasource;

  HistoryLocalDatasourceImpl({
    required HiveInterface datasource,
  }) : _datasource = datasource;

  Box<HistoryAction>? _historySource;
  List<HistoryAction>? _cachedHistory;

  @override
  Future<void> closeSession() async {
    if (_historySource != null) {
      _historySource!.close();
      _historySource = null;
      _cachedHistory = null;
    }
  }

  @override
  Future<HistoryAction> deleteHistoryAction(int id) async {
    final action = getSingleAction(id);
    await _historySource!.delete(action.id);
    _cachedHistory = null;
    return action;
  }

  @override
  List<HistoryAction>? getHistory() {
    if (_historySource == null) {
      return null;
    }
    _cachedHistory ??= _historySource!.values.toList();
    if (_cachedHistory!.isNotEmpty) {
      _cachedHistory!.sort((a, b) => a.id.compareTo(b.id));
    }

    return _cachedHistory;
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
    _cachedHistory = null;
    return action;
  }

  @override
  HistoryAction getSingleAction(int index) {
    if (_historySource == null) {
      throw ProductsSessionNotOpenedException();
    }
    final action = _historySource!.get(index);

    if (action == null) {
      throw HistoryActionNotFoundException();
    }
    return action;
  }
}
