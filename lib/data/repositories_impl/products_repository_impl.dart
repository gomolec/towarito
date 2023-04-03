import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/products_entity.dart';
import '../../domain/repositories/products_repository.dart';
import '../datasources/products_local_datasource.dart';
import '../models/product_model.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsLocalDatasource _source;

  ProductsRepositoryImpl({
    required ProductsLocalDatasource source,
  }) : _source = source;

  final _productsStreamController = BehaviorSubject<ProductsEntity>.seeded(
    const ProductsEntity(),
  );

  @override
  Stream<ProductsEntity> observeProductsData() =>
      _productsStreamController.stream;

  @override
  Future<Either<Failure, None>> openSession({required String id}) async {
    try {
      await _source.openSession(id);
      _refreshProductsStreamData();
      return const Right(None());
    } catch (e) {
      return Left(OpenProductsSessionFailure('$e [id: $id]'));
    }
  }

  @override
  Future<Either<Failure, None>> closeSession() async {
    try {
      await _source.closeSession();
      _refreshProductsStreamData();
      return const Right(None());
    } catch (e) {
      return Left(CloseProductsSessionFailure('$e [id: $id]'));
    }
  }

  @override
  Future<Either<Failure, Product>> createProduct(
      {required Product product}) async {
    try {
      final createdProduct = await _source.saveProduct(product);
      _refreshProductsStreamData();
      return Right(createdProduct);
    } catch (e) {
      return Left(CreateProductFailure('$e [id: $id]'));
    }
  }

  @override
  Future<Either<Failure, Product>> deleteProduct({required String id}) async {
    try {
      final deletedProduct = await _source.deleteProduct(id);
      _refreshProductsStreamData();
      return Right(deletedProduct);
    } catch (e) {
      return Left(DeleteProductFailure('$e [id: $id]'));
    }
  }

  @override
  Future<Either<Failure, Product>> getProduct({required String id}) async {
    try {
      final product = _source.getSingleProduct(id);
      return Right(product);
    } catch (e) {
      return Left(GetProductFailure('$e [id: $id]'));
    }
  }

  @override
  Future<Either<Failure, Product>> updateProduct(
      {required Product product}) async {
    try {
      final updatedProduct = await _source.saveProduct(product);
      _refreshProductsStreamData();
      return Right(updatedProduct);
    } catch (e) {
      return Left(UpdateProductFailure('$e [id: $id]'));
    }
  }

  void _refreshProductsStreamData() {
    final products = _source.getProducts();
    final data = ProductsEntity(
      products: products != null ? List.of(products) : null,
    );
    _productsStreamController.add(data);
  }

  void dispose() {
    _productsStreamController.close();
  }
}
