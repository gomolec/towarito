import 'package:auto_route/auto_route.dart';

import 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: HomeRoute.page,
          children: [
            AutoRoute(
              path: 'dashboard',
              page: DashboardRoute.page,
            ),
            AutoRoute(
              path: 'products',
              page: ProductsRoute.page,
            ),
            AutoRoute(
              path: 'scanner',
              page: ScannerRoute.page,
            ),
            AutoRoute(
              path: 'history',
              page: HistoryRoute.page,
            ),
            AutoRoute(
              path: 'menu',
              page: MenuRoute.page,
            )
          ],
        ),
        AutoRoute(
          path: '/sessions',
          page: SessionsRoute.page,
        ),
        AutoRoute(
          path: '/session/:id',
          page: SessionRoute.page,
        ),
        AutoRoute(
          path: '/product/:id',
          page: ProductRoute.page,
        ),
      ];
}
