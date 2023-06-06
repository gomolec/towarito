import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../presentation/pages/pages.dart';
import '../../presentation/screens/screens.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: HomeRouterRoute.page,
          children: [
            AutoRoute(
              path: 'dashboard',
              page: DashboardRouterRoute.page,
              children: [
                AutoRoute(
                  path: '',
                  page: DashboardRoute.page,
                ),
                RedirectRoute(path: '*', redirectTo: ''),
              ],
            ),
            AutoRoute(
              path: 'products',
              page: ProductsRouterRoute.page,
              children: [
                AutoRoute(
                  path: '',
                  page: ProductsRoute.page,
                ),
                AutoRoute(
                  path: 'details/:id',
                  page: ProductRoute.page,
                ),
                RedirectRoute(path: '*', redirectTo: ''),
              ],
            ),
            AutoRoute(
              path: 'scanner',
              page: ScannerRouterRoute.page,
              children: [
                AutoRoute(
                  path: '',
                  page: ScannerRoute.page,
                ),
                RedirectRoute(path: '*', redirectTo: ''),
              ],
            ),
            AutoRoute(
              path: 'history',
              page: HistoryRouterRoute.page,
              children: [
                AutoRoute(
                  path: '',
                  page: HistoryRoute.page,
                ),
                RedirectRoute(path: '*', redirectTo: ''),
              ],
            ),
            AutoRoute(
              path: 'menu',
              page: MenuRouterRoute.page,
              children: [
                AutoRoute(
                  path: '',
                  page: MenuRoute.page,
                ),
                AutoRoute(
                  path: 'import',
                  page: ImportRoute.page,
                ),
                AutoRoute(
                  path: 'sessions',
                  page: SessionsRouterRoute.page,
                  children: [
                    AutoRoute(
                      path: '',
                      page: SessionsRoute.page,
                    ),
                    AutoRoute(
                      path: 'details/:id',
                      page: SessionRoute.page,
                    ),
                    RedirectRoute(path: '*', redirectTo: ''),
                  ],
                ),
                RedirectRoute(path: '*', redirectTo: ''),
              ],
            ),
          ],
        ),
        RedirectRoute(path: '*', redirectTo: '/dashboard'),
      ];
}
