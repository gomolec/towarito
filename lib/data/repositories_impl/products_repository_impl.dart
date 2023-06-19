import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';
import 'package:towarito/core/error/exceptions.dart';
import 'package:towarito/core/services/import_service.dart';
import 'package:towarito/core/utilities/import_results.dart';
import 'package:towarito/data/datasources/products_remote_datasource.dart';

import '../../core/error/failures.dart';
import '../../core/utilities/imported_file_structure.dart';
import '../../domain/entities/products_entity.dart';
import '../../domain/repositories/products_repository.dart';
import '../datasources/products_local_datasource.dart';
import '../models/product_model.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsLocalDatasource _localSource;
  final ProductsRemoteDatasource _remoteSource;
  final ImportService _importService;

  ProductsRepositoryImpl({
    required ProductsLocalDatasource localSource,
    required ProductsRemoteDatasource remoteSource,
    required ImportService importService,
  })  : _localSource = localSource,
        _remoteSource = remoteSource,
        _importService = importService;

  final _productsStreamController = BehaviorSubject<ProductsEntity>.seeded(
    const ProductsEntity(),
  );

  @override
  Stream<ProductsEntity> observeProductsData() =>
      _productsStreamController.stream;

  @override
  Future<Either<Failure, None>> openSession({required String id}) async {
    try {
      await _localSource.openSession(id);
      _refreshProductsStreamData();
      return const Right(None());
    } catch (e) {
      return Left(OpenProductsSessionFailure('$e [id: $id]'));
    }
  }

  @override
  Future<Either<Failure, None>> closeSession() async {
    try {
      await _localSource.closeSession();
      _refreshProductsStreamData();
      return const Right(None());
    } catch (e) {
      return Left(CloseProductsSessionFailure('$e'));
    }
  }

  @override
  Future<Either<Failure, Product>> createProduct(
      {required Product product}) async {
    try {
      final createdProduct = await _localSource.saveProduct(product);
      _refreshProductsStreamData();
      return Right(createdProduct);
    } catch (e) {
      return Left(CreateProductFailure('$e [id: ${product.id}]'));
    }
  }

  @override
  Future<Either<Failure, Product>> deleteProduct({required String id}) async {
    try {
      final deletedProduct = await _localSource.deleteProduct(id);
      _refreshProductsStreamData();
      return Right(deletedProduct);
    } catch (e) {
      return Left(DeleteProductFailure('$e [id: $id]'));
    }
  }

  @override
  Future<Either<Failure, Product>> getProduct({required String id}) async {
    try {
      final product = _localSource.getSingleProduct(id);
      return Right(product);
    } on ProductNotFoundException {
      return Left(ProductNotFoundFailure(' [id: $id]'));
    } catch (e) {
      return Left(GetProductFailure('$e [id: $id]'));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductByCode(
      {required String code}) async {
    try {
      final product = _localSource.getSingleProductByCode(code);
      return Right(product);
    } on ProductNotFoundException {
      return Left(ProductNotFoundFailure(' [code: $code]'));
    } catch (e) {
      return Left(GetProductFailure('$e [code: $code]'));
    }
  }

  @override
  Future<Either<Failure, Product>> updateProduct(
      {required Product product}) async {
    try {
      final updatedProduct = await _localSource.saveProduct(product.copyWith(
        updated: DateTime.now(),
      ));
      _refreshProductsStreamData();
      return Right(updatedProduct);
    } catch (e) {
      return Left(UpdateProductFailure('$e [id: ${product.id}]'));
    }
  }

  void _refreshProductsStreamData() {
    final products = _localSource.getProducts();
    final data = ProductsEntity(
      products: products != null ? List.of(products) : null,
    );
    _productsStreamController.add(data);
  }

  void dispose() {
    _productsStreamController.close();
  }

  @override
  Future<Either<Failure, List<String>>> importFile({required File file}) async {
    try {
      final data = await _importService.importFile(file: file);
      return Right(data);
    } on FileExtensionNotSupportedException {
      return const Left(ImportFileFailure('Niewspierane rozszerzenie pliku'));
    } on EmptyFileException {
      return const Left(ImportFileFailure('Plik jest pusty'));
    } catch (e) {
      return Left(ImportFileFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ImportResults>> importProducts({
    required ImportedFileStructure structure,
  }) async {
    if (_importService.cachedData == null) {
      return const Left(ImportProductsFailure('Brak zaimportowanego pliku'));
    }

    int successedProduct = 0;
    int failedProducts = 0;

    String errorText = '';

    if (_importService.cachedData!.isEmpty) {
      return const Left(ImportProductsFailure('Plik jest pusty'));
    }

    final columns = _importService.cachedData!..removeAt(0);

    for (var row in columns) {
      try {
        final product = _importService.convertDataToProduct(
          structure: structure,
          data: row,
        );
        await _localSource.saveProduct(product);
        successedProduct++;
      } catch (e) {
        if (e is ProductsSessionNotOpenedException) {
          return const Left(ImportProductsFailure('Brak aktywnej sesji'));
        }
        if (failedProducts > 0) {
          errorText += "\n";
        }
        failedProducts++;
        errorText += "$failedProducts) $row - ${e.toString()}";
      }
    }
    _importService.clearCache();
    _refreshProductsStreamData();
    return Right(ImportResults(
      successedProductsNumber: successedProduct,
      failedProductsNumber: failedProducts,
      errorText: errorText,
    ));
  }

  @override
  Future<Either<Failure, Product>> updateProductRemoteData(
      {required Product product}) async {
    late final Product updatedProduct;
    try {
      updatedProduct = await _localSource.saveProduct(
        await _remoteSource.getProductRemoteData(product),
      );
    } on ConnectionException {
      return const Left(DownloadProductsRemoteDataFailure(
        'Brak dostępu do internetu',
      ));
    } catch (e) {
      return Left(DownloadProductsRemoteDataFailure(e.toString()));
    }
    _refreshProductsStreamData();
    return Right(updatedProduct);
  }

  @override
  Future<Either<Failure, None>> updateProductsRemoteData() async {
    late final List<Product>? products;
    try {
      products = _localSource.getProducts();
      if (products == null) {
        throw SessionNotFoundException;
      }
    } catch (e) {
      return const Left(DownloadProductsRemoteDataFailure(''));
    }
    int errorsCount = 0;
    String errorText = '';
    for (var product in products) {
      if (errorsCount >= 5) {
        return Left(DownloadProductsRemoteDataFailure(
          'Przekroczono maksymalną liczbę błędów (5). $errorText',
        ));
      }
      if (product.url != null) {
        continue;
      }
      try {
        await _localSource.saveProduct(
          await _remoteSource.getProductRemoteData(product),
        );
      } on ConnectionException {
        return const Left(DownloadProductsRemoteDataFailure(
          'Brak dostępu do internetu',
        ));
      } catch (e) {
        errorsCount++;
        errorText += '$e\n';
      }
    }
    _refreshProductsStreamData();
    return const Right(None());
  }
}
