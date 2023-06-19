import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../core/utilities/import_results.dart';
import '../../core/utilities/imported_file_structure.dart';
import '../../data/models/models.dart';
import '../entities/products_entity.dart';

abstract class ProductsRepository {
  Stream<ProductsEntity> observeProductsData();

  Future<Either<Failure, Product>> getProduct({required String id});

  Future<Either<Failure, Product>> getProductByCode({required String code});

  Future<Either<Failure, Product>> createProduct({required Product product});

  Future<Either<Failure, Product>> updateProduct({required Product product});

  Future<Either<Failure, Product>> deleteProduct({required String id});

  Future<Either<Failure, List<String>>> importFile({required File file});

  Future<Either<Failure, ImportResults>> importProducts(
      {required ImportedFileStructure structure});

  Future<Either<Failure, None>> openSession({required String id});

  Future<Either<Failure, None>> closeSession();

  Future<Either<Failure, Product>> updateProductRemoteData(
      {required Product product});

  Future<Either<Failure, None>> updateProductsRemoteData();
}
