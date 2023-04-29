import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../core/extensions/either_extension.dart';
import '../../data/models/models.dart';
import '../entities/history_entity.dart';
import '../repositories/repositories.dart';

class HistoryAdapter {
  final ProductsRepository _productsRepository;
  final HistoryRepository _historyRepository;

  const HistoryAdapter({
    required ProductsRepository productsRepository,
    required HistoryRepository historyRepository,
  })  : _productsRepository = productsRepository,
        _historyRepository = historyRepository;

  Stream<HistoryEntity> observeHistoryData() =>
      _historyRepository.observeHistoryData();

  Future<Either<Failure, None>> undo() async {
    final historyResult = await _historyRepository.undoAction();
    if (historyResult.isLeft()) {
      return Left(historyResult.asLeft());
    }
    final undoAction = historyResult.asRight();
    late final Either<Failure, Product> productsResult;
    switch (undoAction.actionType) {
      case HistoryActionType.created:
        productsResult = await _productsRepository.deleteProduct(
            id: undoAction.updatedProduct!.id);
        break;
      case HistoryActionType.updated:
        productsResult = await _productsRepository.updateProduct(
            product: undoAction.oldProduct!);
        break;
      case HistoryActionType.deleted:
        productsResult = await _productsRepository.createProduct(
            product: undoAction.oldProduct!);
        break;
    }
    if (productsResult.isLeft()) {
      return Left(productsResult.asLeft());
    }
    return const Right(None());
  }

  Future<Either<Failure, None>> redo() async {
    final historyResult = await _historyRepository.redoAction();
    if (historyResult.isLeft()) {
      return Left(historyResult.asLeft());
    }
    final redoAction = historyResult.asRight();
    late final Either<Failure, Product> productsResult;
    switch (redoAction.actionType) {
      case HistoryActionType.created:
        productsResult = await _productsRepository.createProduct(
            product: redoAction.updatedProduct!);
        break;
      case HistoryActionType.updated:
        productsResult = await _productsRepository.updateProduct(
            product: redoAction.updatedProduct!);
        break;
      case HistoryActionType.deleted:
        productsResult = await _productsRepository.deleteProduct(
            id: redoAction.oldProduct!.id);
        break;
    }
    if (productsResult.isLeft()) {
      return Left(productsResult.asLeft());
    }
    return const Right(None());
  }
}
