import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:towarito/core/error/failures.dart';
import 'package:towarito/data/models/models.dart';
import 'package:towarito/domain/adapters/products_adapter.dart';
import 'package:towarito/domain/repositories/repositories.dart';

class MockProductsRepository extends Mock implements ProductsRepository {}

class MockHistoryRepository extends Mock implements HistoryRepository {}

class ProductFake extends Fake implements Product {}

class HistoryActionFake extends Fake implements HistoryAction {}

class TestFailure extends Failure {
  const TestFailure(super.text);
}

void main() {
  late ProductsAdapter sut;
  late ProductsRepository mockProductsRepository;
  late HistoryRepository mockHistoryRepository;

  setUpAll(() {
    registerFallbackValue(ProductFake());
    registerFallbackValue(HistoryActionFake());
  });

  setUp(() {
    mockProductsRepository = MockProductsRepository();
    mockHistoryRepository = MockHistoryRepository();
    sut = ProductsAdapter(
      productsRepository: mockProductsRepository,
      historyRepository: mockHistoryRepository,
    );
  });

  group(
    "createProduct",
    () {
      final testProduct = Product(id: "1234", name: "test");
      const testFailure = TestFailure('error');
      test(
        'should return Left when productsRepo return Left, and historyRepo should not be called',
        () async {
          when(() => mockProductsRepository.createProduct(
                  product: any(named: 'product')))
              .thenAnswer((invocation) async => const Left(testFailure));
          when(() =>
                  mockHistoryRepository.addAction(action: any(named: 'action')))
              .thenAnswer((invocation) async => const Right(None()));

          final result = await sut.createProduct(product: testProduct);

          verify(() => mockProductsRepository.createProduct(
              product: any(named: 'product'))).called(1);

          verifyNever(() =>
              mockHistoryRepository.addAction(action: any(named: 'action')));

          expect(result, const Left(testFailure));
        },
      );
    },
  );
}
