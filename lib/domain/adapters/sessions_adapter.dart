import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../data/models/session_model.dart';
import '../entities/sessions_entity.dart';
import '../repositories/repositories.dart';

class SessionsAdapter {
  final SessionsRepository _sessionsRepository;
  final ProductsRepository _productsRepository;
  final HistoryRepository _historyRepository;

  const SessionsAdapter({
    required SessionsRepository sessionsRepository,
    required ProductsRepository productsRepository,
    required HistoryRepository historyRepository,
  })  : _sessionsRepository = sessionsRepository,
        _productsRepository = productsRepository,
        _historyRepository = historyRepository;

  Stream<SessionsEntity> observeSessionsData() =>
      _sessionsRepository.observeSessionsData();

  Future<Either<Failure, Session>> createSession({required Session session}) =>
      _sessionsRepository.createSession(session: session);

  Future<Either<Failure, None>> deleteSession({required String id}) =>
      _sessionsRepository.deleteSession(id: id);

  Future<Either<Failure, None>> finishCurrentSession() async {
    final sessionsResult = await _sessionsRepository.finishCurrentSession();
    if (sessionsResult.isLeft()) {
      return sessionsResult;
    }
    final productsResult = await _productsRepository.closeSession();
    if (productsResult.isLeft()) {
      return productsResult;
    }
    final historyResult = await _historyRepository.closeSession();
    return historyResult;
  }

  Future<Either<Failure, Session>> getSession({required String id}) =>
      _sessionsRepository.getSession(id: id);

  Future<Either<Failure, Session?>> getCurrentSession() =>
      _sessionsRepository.getCurrentSession();

  Future<Either<Failure, None>> startCurrentSession(
      {required String id}) async {
    final sessionsResult =
        await _sessionsRepository.startCurrentSession(id: id);
    if (sessionsResult.isLeft()) {
      return sessionsResult;
    }
    final productsResult = await _productsRepository.openSession(id: id);
    if (productsResult.isLeft()) {
      return productsResult;
    }
    final historyResult = await _historyRepository.openSession(id: id);
    return historyResult;
  }

  Future<Either<Failure, None>> updateSession({required Session session}) =>
      _sessionsRepository.updateSession(session: session);
}
