import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:towarito/core/error/failures.dart';
import 'package:towarito/domain/adapters/sessions_adapter.dart';
import 'package:towarito/domain/repositories/repositories.dart';

class MockSessionsRepository extends Mock implements SessionsRepository {}

class MockProductsRepository extends Mock implements ProductsRepository {}

class MockHistoryRepository extends Mock implements HistoryRepository {}

class TestFailure extends Failure {
  const TestFailure(super.text);
}

void main() {
  late SessionsAdapter sut;
  late SessionsRepository mockSessionsRepository;
  late ProductsRepository mockProductsRepository;
  late HistoryRepository mockHistoryRepository;

  setUp(() {
    mockSessionsRepository = MockSessionsRepository();
    mockProductsRepository = MockProductsRepository();
    mockHistoryRepository = MockHistoryRepository();
    sut = SessionsAdapter(
      sessionsRepository: mockSessionsRepository,
      productsRepository: mockProductsRepository,
      historyRepository: mockHistoryRepository,
    );
  });

  group(
    "startCurrentSession",
    () {
      test(
        "should return Right(None()) when succesfully start session at all of the repositories",
        () async {
          const testSessionId = "1234";

          when(() =>
                  mockSessionsRepository.startCurrentSession(id: testSessionId))
              .thenAnswer((invocation) async => const Right(None()));

          when(() => mockProductsRepository.openSession(id: testSessionId))
              .thenAnswer((invocation) async => const Right(None()));

          when(() => mockHistoryRepository.openSession(id: testSessionId))
              .thenAnswer((invocation) async => const Right(None()));

          final result = await sut.startCurrentSession(id: testSessionId);

          verify(() => mockSessionsRepository.startCurrentSession(
              id: any(named: 'id'))).called(1);

          verify(() => mockProductsRepository.openSession(id: any(named: 'id')))
              .called(1);

          verify(() => mockHistoryRepository.openSession(id: any(named: 'id')))
              .called(1);

          expect(result, const Right(None()));
        },
      );

      test(
        "should return Left(Failure()) when the sessionRepository return Left() and the rest of the repositories should not be called",
        () async {
          const testSessionId = "1234";

          when(() =>
                  mockSessionsRepository.startCurrentSession(id: testSessionId))
              .thenAnswer((invocation) async => const Left(TestFailure('')));

          when(() => mockProductsRepository.openSession(id: testSessionId))
              .thenAnswer((invocation) async => const Right(None()));

          when(() => mockHistoryRepository.openSession(id: testSessionId))
              .thenAnswer((invocation) async => const Right(None()));

          final result = await sut.startCurrentSession(id: testSessionId);

          verify(() => mockSessionsRepository.startCurrentSession(
              id: any(named: 'id'))).called(1);

          verifyNever(
              () => mockProductsRepository.openSession(id: any(named: 'id')));

          verifyNever(
              () => mockHistoryRepository.openSession(id: any(named: 'id')));

          expect(result, const Left(TestFailure('')));
        },
      );

      test(
        "should return Left(Failure()) when the productsRepository return Left() and the HistoryRepository should not be called",
        () async {
          const testSessionId = "1234";

          when(() =>
                  mockSessionsRepository.startCurrentSession(id: testSessionId))
              .thenAnswer((invocation) async => const Right(None()));

          when(() => mockProductsRepository.openSession(id: testSessionId))
              .thenAnswer((invocation) async => const Left(TestFailure('')));

          when(() => mockHistoryRepository.openSession(id: testSessionId))
              .thenAnswer((invocation) async => const Right(None()));

          final result = await sut.startCurrentSession(id: testSessionId);

          verify(() => mockSessionsRepository.startCurrentSession(
              id: any(named: 'id'))).called(1);

          verify(() => mockProductsRepository.openSession(id: any(named: 'id')))
              .called(1);

          verifyNever(
              () => mockHistoryRepository.openSession(id: any(named: 'id')));

          expect(result, const Left(TestFailure('')));
        },
      );

      test(
        "should return Left(Failure()) when the historyRepository return Left()",
        () async {
          const testSessionId = "1234";

          when(() =>
                  mockSessionsRepository.startCurrentSession(id: testSessionId))
              .thenAnswer((invocation) async => const Right(None()));

          when(() => mockProductsRepository.openSession(id: testSessionId))
              .thenAnswer((invocation) async => const Right(None()));

          when(() => mockHistoryRepository.openSession(id: testSessionId))
              .thenAnswer((invocation) async => const Left(TestFailure('')));

          final result = await sut.startCurrentSession(id: testSessionId);

          verify(() => mockSessionsRepository.startCurrentSession(
              id: any(named: 'id'))).called(1);

          verify(() => mockProductsRepository.openSession(id: any(named: 'id')))
              .called(1);

          verify(() => mockHistoryRepository.openSession(id: any(named: 'id')))
              .called(1);

          expect(result, const Left(TestFailure('')));
        },
      );
    },
  );

  group(
    "finishCurrentSession",
    () {
      test(
        "should return Right(None()) when succesfully finished session at all of the repositories",
        () async {
          when(() => mockSessionsRepository.finishCurrentSession())
              .thenAnswer((invocation) async => const Right(None()));

          when(() => mockProductsRepository.closeSession())
              .thenAnswer((invocation) async => const Right(None()));

          when(() => mockHistoryRepository.closeSession())
              .thenAnswer((invocation) async => const Right(None()));

          final result = await sut.finishCurrentSession();

          verify(() => mockSessionsRepository.finishCurrentSession()).called(1);

          verify(() => mockProductsRepository.closeSession()).called(1);

          verify(() => mockHistoryRepository.closeSession()).called(1);

          expect(result, const Right(None()));
        },
      );

      test(
        "should return Left(Failure()) when the sessionRepository return Left() and the rest of the repositories should not be called",
        () async {
          when(() => mockSessionsRepository.finishCurrentSession())
              .thenAnswer((invocation) async => const Left(TestFailure('')));

          when(() => mockProductsRepository.closeSession())
              .thenAnswer((invocation) async => const Right(None()));

          when(() => mockHistoryRepository.closeSession())
              .thenAnswer((invocation) async => const Right(None()));

          final result = await sut.finishCurrentSession();

          verify(() => mockSessionsRepository.finishCurrentSession()).called(1);

          verifyNever(() => mockProductsRepository.closeSession());

          verifyNever(() => mockHistoryRepository.closeSession());

          expect(result, const Left(TestFailure('')));
        },
      );

      test(
        "should return Left(Failure()) when the productsRepository return Left() and the HistoryRepository should not be called",
        () async {
          when(() => mockSessionsRepository.finishCurrentSession())
              .thenAnswer((invocation) async => const Right(None()));

          when(() => mockProductsRepository.closeSession())
              .thenAnswer((invocation) async => const Left(TestFailure('')));

          when(() => mockHistoryRepository.closeSession())
              .thenAnswer((invocation) async => const Right(None()));

          final result = await sut.finishCurrentSession();

          verify(() => mockSessionsRepository.finishCurrentSession()).called(1);

          verify(() => mockProductsRepository.closeSession()).called(1);

          verifyNever(() => mockHistoryRepository.closeSession());

          expect(result, const Left(TestFailure('')));
        },
      );

      test(
        "should return Left(Failure()) when the historyRepository return Left()",
        () async {
          when(() => mockSessionsRepository.finishCurrentSession())
              .thenAnswer((invocation) async => const Right(None()));

          when(() => mockProductsRepository.closeSession())
              .thenAnswer((invocation) async => const Right(None()));

          when(() => mockHistoryRepository.closeSession())
              .thenAnswer((invocation) async => const Left(TestFailure('')));

          final result = await sut.finishCurrentSession();

          verify(() => mockSessionsRepository.finishCurrentSession()).called(1);

          verify(() => mockProductsRepository.closeSession()).called(1);

          verify(() => mockHistoryRepository.closeSession()).called(1);

          expect(result, const Left(TestFailure('')));
        },
      );
    },
  );
}
