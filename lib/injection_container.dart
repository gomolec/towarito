import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:towarito/core/navigation/app_router.dart';
import 'package:towarito/core/services/connection_service.dart';
import 'package:towarito/core/services/import_service.dart';
import 'package:towarito/data/datasources/products_remote_datasource.dart';

import 'core/app/app_scaffold_messager.dart';
import 'core/constants/constants.dart';
import 'core/utilities/products_querier.dart';
import 'core/utilities/products_sorter.dart';
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
  sl.registerLazySingleton<Connectivity>(
    () => Connectivity(),
  );

  //! Utilities
  sl.registerLazySingleton<ProductsQuerier>(
    () => const ProductsQuerier(),
  );
  sl.registerLazySingleton<ProductsSorter>(
    () => const ProductsSorter(),
  );

  //! Services
  sl.registerLazySingleton<ImportService>(
    () => ImportService(),
  );

  sl.registerLazySingleton<ConnectionService>(
    () => ConnectionService(
      connectivity: sl<Connectivity>(),
    ),
  );

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
      productsRepository: sl<ProductsRepository>(),
      historyRepository: sl<HistoryRepository>(),
      sessionsRepository: sl<SessionsRepository>(),
    ),
  );

  sl.registerLazySingleton<HistoryAdapter>(
    () => HistoryAdapter(
      productsRepository: sl<ProductsRepository>(),
      historyRepository: sl<HistoryRepository>(),
    ),
  );

  sl.registerLazySingleton<SessionsAdapter>(
    () => SessionsAdapter(
      sessionsRepository: sl<SessionsRepository>(),
      productsRepository: sl<ProductsRepository>(),
      historyRepository: sl<HistoryRepository>(),
    ),
  );

  //! Respositories
  sl.registerLazySingleton<ProductsRepository>(
    () => ProductsRepositoryImpl(
      localSource: sl<ProductsLocalDatasource>(),
      remoteSource: sl<ProductsRemoteDatasource>(),
      importService: sl<ImportService>(),
    ),
  );

  sl.registerLazySingleton<HistoryRepository>(
    () => HistoryRepositoryImpl(source: sl<HistoryLocalDatasource>()),
  );

  sl.registerLazySingleton<SessionsRepository>(
    () => SessionsRepositoryImpl(source: sl<SessionsLocalDatasource>()),
  );

  //! Data sources
  sl.registerLazySingletonAsync<SessionsLocalDatasource>(() async {
    final currentSessionIdSource = await Hive.openBox(kCurrentSessionIdBoxName);
    await currentSessionIdSource.clear();
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

  sl.registerLazySingleton<ProductsRemoteDatasource>(
    () => ProductsRemoteDatasourceImpl(),
  );
}
