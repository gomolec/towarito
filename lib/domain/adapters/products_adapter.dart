import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../core/extensions/either_extension.dart';
import '../../core/utilities/import_results.dart';
import '../../core/utilities/imported_file_structure.dart';
import '../../data/models/models.dart';
import '../entities/products_entity.dart';
import '../repositories/repositories.dart';

class ProductsAdapter {
  final ProductsRepository _productsRepository;
  final HistoryRepository _historyRepository;
  final SessionsRepository _sessionsRepository;

  const ProductsAdapter({
    required ProductsRepository productsRepository,
    required HistoryRepository historyRepository,
    required SessionsRepository sessionsRepository,
  })  : _productsRepository = productsRepository,
        _historyRepository = historyRepository,
        _sessionsRepository = sessionsRepository;

  Future<Either<Failure, Product>> createProduct(
      {required Product product}) async {
    final productsResult =
        await _productsRepository.createProduct(product: product);
    if (productsResult.isLeft()) {
      return productsResult;
    }
    final historyResult = await _historyRepository.addAction(
      updatedProduct: productsResult.asRight(),
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
      oldProduct: productsResult.asRight(),
    );

    if (historyResult.isLeft()) {
      return Left(historyResult.asLeft());
    }
    return productsResult;
  }

  Future<Either<Failure, Product>> getProduct({required String id}) =>
      _productsRepository.getProduct(id: id);

  Future<Either<Failure, Product>> getProductByCode({required String code}) =>
      _productsRepository.getProductByCode(code: code);

  Stream<ProductsEntity> observeProductsData() =>
      _productsRepository.observeProductsData();

  Future<Either<Failure, Product>> updateProduct(
      {required Product product}) async {
    final oldProductResult =
        await _productsRepository.getProduct(id: product.id);
    if (oldProductResult.isLeft()) {
      return oldProductResult;
    }
    final productsResult =
        await _productsRepository.updateProduct(product: product);
    if (productsResult.isLeft()) {
      return productsResult;
    }
    final historyResult = await _historyRepository.addAction(
      oldProduct: oldProductResult.asRight(),
      updatedProduct: productsResult.asRight(),
    );

    if (historyResult.isLeft()) {
      return Left(historyResult.asLeft());
    }
    return productsResult;
  }

  Future<Either<Failure, None>> updateProductsRemoteData() async {
    final canDownloadRemoteData = await _canDownloadRemoteData();
    if (canDownloadRemoteData.isLeft()) {
      return Left(canDownloadRemoteData.asLeft());
    }
    final result = await _productsRepository.updateProductsRemoteData();
    return result;
  }

  Future<Either<Failure, Product>> updateProductRemoteData(
      {required Product product}) async {
    final canDownloadRemoteData = await _canDownloadRemoteData();
    if (canDownloadRemoteData.isLeft()) {
      return Left(canDownloadRemoteData.asLeft());
    }
    final result =
        await _productsRepository.updateProductRemoteData(product: product);
    return result;
  }

  Future<Either<Failure, Session>> _canDownloadRemoteData() async {
    final currentSession = await _sessionsRepository.getCurrentSession();
    if (currentSession.isLeft()) {
      return Left(currentSession.asLeft());
    }
    if (currentSession.asRight() == null) {
      return const Left(NoCurrentSessionFailure(''));
    }
    if (currentSession.asRight()!.useRemoteData == false) {
      return const Left(RemoteDataDisabledFailure(''));
    }
    return Right(currentSession.asRight()!);
  }

  Future<Either<Failure, List<String>>> importFile({required File file}) =>
      _productsRepository.importFile(file: file);

  Future<Either<Failure, ImportResults>> importProducts({
    required ImportedFileStructure structure,
  }) =>
      _productsRepository.importProducts(structure: structure);
}
