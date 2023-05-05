import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../data/models/models.dart';
import '../entities/sessions_entity.dart';

abstract class SessionsRepository {
  Stream<SessionsEntity> observeSessionsData();

  Future<Either<Failure, Session>> getSession({required String id});

  Future<Either<Failure, Session?>> getCurrentSession();

  Future<Either<Failure, Session>> createSession({required Session session});

  Future<Either<Failure, None>> updateSession({required Session session});

  Future<Either<Failure, None>> deleteSession({required String id});

  Future<Either<Failure, None>> startCurrentSession({required String id});

  Future<Either<Failure, None>> finishCurrentSession();
}
