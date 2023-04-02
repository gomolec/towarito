import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../data/models/models.dart';
import '../entities/history_entity.dart';

abstract class HistoryRepository {
  Stream<HistoryEntity> observeHistoryData();

  Future<Either<Failure, None>> addAction({required HistoryAction action});

  Future<Either<Failure, HistoryAction>> undoAction();

  Future<Either<Failure, HistoryAction>> redoAction();

  Future<Either<Failure, None>> openSession({required String id});

  Future<Either<Failure, None>> closeSession();
}
