import 'package:hive_flutter/hive_flutter.dart';

import '../../core/constants/constants.dart';
import '../../core/error/exceptions.dart';
import '../models/models.dart';

abstract class ProductsLocalDatasource {
  /// Open product's session with give [Id]
  ///
  /// If such a session does not exist, it creates one.
  Future<void> openSession(String id);

  /// Close product's session;
  ///
  /// If no session is open, nothing happens
  Future<void> closeSession();

  /// Returns a nullable [List] of all sessions.
  ///
  /// Null is returned when session is not opened.
  List<Product>? getProducts();

  /// Returns a single [Product] with the given id.
  ///
  /// If no product with the given id exists, a [ProductNotFoundException] error is
  /// thrown.
  Product getSingleProduct(String id);

  /// Saves and returns a [Product].
  ///
  /// If a [Product] with the same id already exists, it will be replaced.
  Future<Product> saveProduct(Product product);

  /// Deletes and returns the [Product] with the given id.
  ///
  /// If no product with the given id exists, nothing happens.
  Future<Product> deleteProduct(String id);
}

class ProductsLocalDatasourceImpl implements ProductsLocalDatasource {
  final HiveInterface _datasource;

  ProductsLocalDatasourceImpl({
    required HiveInterface datasource,
  }) : _datasource = datasource;

  Box<Product>? _productsSource;

  @override
  Future<void> closeSession() async {
    if (_productsSource != null) {
      _productsSource!.close();
    }
  }

  @override
  Future<Product> deleteProduct(String id) async {
    if (_productsSource == null) {
      throw ProductsSessionNotOpenedException();
    }
    final product = getSingleProduct(id);

    await _productsSource!.delete(product.id);

    return product;
  }

  @override
  List<Product>? getProducts() {
    if (_productsSource != null) {
      return _productsSource!.values.toList();
    }
    return null;
  }

  @override
  Product getSingleProduct(String id) {
    if (_productsSource == null) {
      throw ProductsSessionNotOpenedException();
    }
    final product = _productsSource!.get(id);

    if (product == null) {
      throw ProductNotFoundException();
    }

    return product;
  }

  @override
  Future<void> openSession(String id) async {
    closeSession();
    _productsSource =
        await _datasource.openBox<Product>('$kProductsBoxName$id');
  }

  @override
  Future<Product> saveProduct(Product product) async {
    if (_productsSource == null) {
      throw ProductsSessionNotOpenedException();
    }
    _productsSource!.put(product.id, product);
    return product;
  }
}
