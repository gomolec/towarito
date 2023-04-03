import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../core/extensions/either_extension.dart';
import '../../data/models/models.dart';
import '../entities/products_entity.dart';
import '../repositories/repositories.dart';

class ProductsAdapter {
  final ProductsRepository _productsRepository;
  final HistoryRepository _historyRepository;

  const ProductsAdapter({
    required ProductsRepository productsRepository,
    required HistoryRepository historyRepository,
  })  : _productsRepository = productsRepository,
        _historyRepository = historyRepository;

  Future<Either<Failure, Product>> createProduct(
      {required Product product}) async {
    final productsResult =
        await _productsRepository.createProduct(product: product);
    if (productsResult.isLeft()) {
      return productsResult;
    }
    final historyResult = await _historyRepository.addAction(
      action: HistoryAction(updatedProduct: productsResult.asRight()),
    );

    if (historyResult.isLeft()) {
      return Left(historyResult.asLeft());
    }
    return productsResult;
  }

  Future<Either<Failure, Product>> deleteProduct({required String id}) async {
    final productsResult = await _productsRepository.deleteProduct(id: id);
    if (productsResult.isLeft()) {
      return productsResult;
    }
    final historyResult = await _historyRepository.addAction(
      action: HistoryAction(oldProduct: productsResult.asRight()),
    );

    if (historyResult.isLeft()) {
      return Left(historyResult.asLeft());
    }
    return productsResult;
  }

  Future<Either<Failure, Product>> getProduct({required String id}) =>
      _productsRepository.getProduct(id: id);

  Stream<ProductsEntity> observeProductsData() =>
      _productsRepository.observeProductsData();

  Future<Either<Failure, Product>> updateProduct(
      {required Product product}) async {
    final productsResult =
        await _productsRepository.updateProduct(product: product);
    if (productsResult.isLeft()) {
      return productsResult;
    }
    final historyResult = await _historyRepository.addAction(
      action: HistoryAction(
          oldProduct: product, updatedProduct: productsResult.asRight()),
    );

    if (historyResult.isLeft()) {
      return Left(historyResult.asLeft());
    }
    return productsResult;
  }
}
