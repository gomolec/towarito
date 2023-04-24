import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:towarito/core/app/app_scaffold_messager.dart';

import 'core/constants/constants.dart';
import 'core/navigation/router.dart';
import 'data/datasources/history_local_datasource.dart';
import 'data/datasources/products_local_datasource.dart';
import 'data/datasources/sessions_local_datasource.dart';
import 'data/repositories_impl/history_repository_impl.dart';
import 'data/repositories_impl/products_repository_impl.dart';
import 'data/repositories_impl/sessions_repository_impl.dart';
import 'domain/adapters/history_adapter.dart';
import 'domain/adapters/products_adapter.dart';
import 'domain/adapters/sessions_adapter.dart';
import 'domain/repositories/repositories.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! App
  sl.registerLazySingleton<AppScaffoldMessager>(
    () => AppScaffoldMessager(),
  );

  //! Navigation
  sl.registerLazySingleton<AppRouter>(
    () => AppRouter(),
  );

  //! Adapters
  sl.registerLazySingleton<ProductsAdapter>(
    () => ProductsAdapter(
      productsRepository: sl(),
      historyRepository: sl(),
    ),
  );

  sl.registerLazySingleton<HistoryAdapter>(
    () => HistoryAdapter(
      productsRepository: sl(),
      historyRepository: sl(),
    ),
  );

  sl.registerLazySingleton<SessionsAdapter>(
    () => SessionsAdapter(
      sessionsRepository: sl(),
      productsRepository: sl(),
      historyRepository: sl(),
    ),
  );

  //! Respositories
  sl.registerLazySingleton<ProductsRepository>(
    () => ProductsRepositoryImpl(source: sl()),
  );

  sl.registerLazySingleton<HistoryRepository>(
    () => HistoryRepositoryImpl(source: sl()),
  );

  sl.registerLazySingleton<SessionsRepository>(
    () => SessionsRepositoryImpl(source: sl()),
  );

  //! Data sources
  sl.registerLazySingletonAsync<SessionsLocalDatasource>(() async {
    return SessionsLocalDatasourceImpl(
      sessionsSource: await Hive.openBox(kSessionsBoxName),
      currentSessionIdSource: await Hive.openBox(kCurrentSessionIdBoxName),
    );
  });

  sl.registerLazySingleton<ProductsLocalDatasource>(
    () => ProductsLocalDatasourceImpl(
      datasource: Hive,
    ),
  );

  sl.registerLazySingleton<HistoryLocalDatasource>(
    () => HistoryLocalDatasourceImpl(
      datasource: Hive,
    ),
  );
}
