import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../data/models/models.dart';
import '../entities/products_entity.dart';

abstract class ProductsRepository {
  Stream<ProductsEntity> observeProductsData();

  Future<Either<Failure, Product>> getProduct({required Product id});

  Future<Either<Failure, Product>> createProduct({required Product product});

  Future<Either<Failure, Product>> updateProduct({required Product product});

  Future<Either<Failure, Product>> deleteProduct({required String id});

  Future<Either<Failure, None>> openSession({required String id});

  Future<Either<Failure, None>> closeSession();
}
