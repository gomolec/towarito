import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/constants/constants.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/sessions_entity.dart';
import '../../domain/repositories/repositories.dart';
import '../datasources/sessions_local_datasource.dart';
import '../models/session_model.dart';

class SessionsRepositoryImpl implements SessionsRepository {
  final SessionsLocalDatasource _source;

  SessionsRepositoryImpl({
    required SessionsLocalDatasource source,
  }) : _source = source {
    _refreshSessionsStreamData();
  }

  final _sessionsStreamController = BehaviorSubject<SessionsEntity>.seeded(
    const SessionsEntity(sessions: []),
  );

  @override
  Future<Either<Failure, Session>> createSession(
      {required Session session}) async {
    try {
      final allSessions = _source.getSessions();
      if (allSessions.length == kMaxStoredSessions) {
        return const Left(
            MaxNumberOfSessionReached('[maks. = $kMaxStoredSessions]'));
      }
      await _source.saveSession(session);
      _refreshSessionsStreamData();
      return Right(session);
    } catch (e) {
      return Left(CreateSessionFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, None>> deleteSession({required String id}) async {
    try {
      if (id == _source.getCurrentSession()?.id) {
        return const Left(CannotDeleteCurrentSession(''));
      }
      await _source.deleteSession(id);
      _refreshSessionsStreamData();
      return const Right(None());
    } catch (e) {
      return Left(DeleteSessionFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, None>> finishCurrentSession() async {
    try {
      final finishedSession = _source.getCurrentSession();
      if (finishedSession == null) {
        return const Left(FinishCurrentSessionFailure('Brak aktualnej sesji.'));
      }
      final updatedSession =
          finishedSession.copyWith(finished: () => DateTime.now());
      await _source.deleteCurrentSessionId();
      await _source.saveSession(updatedSession);
      _refreshSessionsStreamData();
      return const Right(None());
    } catch (e) {
      return Left(FinishCurrentSessionFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Session>> getSession({required String id}) async {
    try {
      return Right(_source.getSingleSession(id));
    } on SessionNotFoundException {
      return Left(SessionNotFoundFailure(id));
    } catch (e) {
      return Left(GetSessionFailure('$e. $id'));
    }
  }

  @override
  Future<Either<Failure, Session?>> getCurrentSession() async {
    try {
      return Right(_source.getCurrentSession());
    } catch (e) {
      return Left(GetCurrentSessionFailure('$e. $id'));
    }
  }

  @override
  Stream<SessionsEntity> observeSessionsData() =>
      _sessionsStreamController.stream;

  @override
  Future<Either<Failure, None>> startCurrentSession(
      {required String id}) async {
    try {
      final currentSession = _source.getCurrentSession();
      if (id == currentSession?.id) {
        return Left(
          StartCurrentSessionFailure(
              'Sesja o id: $id jest już aktualną sesją.'),
        );
      }
      final updatedSession =
          _source.getSingleSession(id).copyWith(finished: () => null);
      await _source.saveCurrentSessionId(updatedSession.id);
      await _source.saveSession(updatedSession);
      _refreshSessionsStreamData();
      return const Right(None());
    } on SessionNotFoundException {
      return Left(StartCurrentSessionFailure('Sesja o id: $id nie istnieje.'));
    } catch (e) {
      return Left(StartCurrentSessionFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, None>> updateSession(
      {required Session session}) async {
    try {
      _source.saveSession(
        session.copyWith(updated: DateTime.now()),
      );
      _refreshSessionsStreamData();
      return const Right(None());
    } catch (e) {
      return Left(UpdateSessionFailure(e.toString()));
    }
  }

  void _refreshSessionsStreamData() {
    final session = _source.getCurrentSession();
    final sessions = List.of(_source.getSessions());
    if (session != null) {
      sessions.remove(session);
    }
    final data = SessionsEntity(
      sessions: sessions,
      currentSession: session,
    );
    _sessionsStreamController.add(data);
  }

  void dispose() {
    _sessionsStreamController.close();
  }
}
