import 'package:hive_flutter/hive_flutter.dart';

import '../../core/constants/constants.dart';
import '../../core/error/exceptions.dart';
import '../models/models.dart';

abstract class SessionsLocalDatasource {
  /// Returns a [List] of all sessions.
  List<Session> getSessions();

  /// Returns a single [Session] with the given id.
  ///
  /// If no session with the given id exists, a [SessionNotFoundException] error is
  /// thrown.
  Session getSingleSession(String id);

  /// Saves a [Session].
  ///
  /// If a [Session] with the same id already exists, it will be replaced.
  Future<void> saveSession(Session session);

  /// Deletes the [Session] with the given id.
  ///
  /// If no session with the given id exists, nothing happens.
  Future<void> deleteSession(String id);

  /// Returns a nullable [Session] with current session.
  Session? getCurrentSession();

  /// Saves a [String] with current session's id.
  ///
  /// If such a value already exists, it will be replaced.
  Future<void> saveCurrentSessionId(String id);

  /// Delete a record with a current session's id.
  ///
  /// If no such a value exists, nothing happens.
  Future<void> deleteCurrentSessionId();
}

class SessionsLocalDatasourceImpl extends SessionsLocalDatasource {
  SessionsLocalDatasourceImpl({
    required Box<Session> sessionsSource,
    required Box<dynamic> currentSessionIdSource,
  })  : _sessionsSource = sessionsSource,
        _currentSessionIdSource = currentSessionIdSource;

  final Box<Session> _sessionsSource;
  final Box<dynamic> _currentSessionIdSource;

  @override
  List<Session> getSessions() {
    return _sessionsSource.values.toList();
  }

  @override
  Session getSingleSession(String id) {
    final session = _sessionsSource.get(id);

    if (session == null) {
      throw SessionNotFoundException();
    }

    return session;
  }

  @override
  Future<void> deleteSession(String id) async {
    getSingleSession(id);

    await _sessionsSource.delete(id);
  }

  @override
  Future<void> saveSession(Session session) async {
    await _sessionsSource.put(session.id, session);
  }

  @override
  Session? getCurrentSession() {
    final currentSessionId =
        _currentSessionIdSource.get(kCurrentSessionIdBoxName);

    if (currentSessionId == null) {
      return null;
    }

    if (currentSessionId is! String) {
      _currentSessionIdSource.delete(kCurrentSessionIdBoxName);
      return null;
    }

    return _sessionsSource.get(currentSessionId);
  }

  @override
  Future<void> saveCurrentSessionId(String id) async {
    await _currentSessionIdSource.put(kCurrentSessionIdBoxName, id);
  }

  @override
  Future<void> deleteCurrentSessionId() async {
    await _currentSessionIdSource.delete(kCurrentSessionIdBoxName);
  }
}
