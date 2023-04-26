// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;
import 'package:towarito/presentation/pages/dashboard/dashboard_page.dart'
    as _i1;
import 'package:towarito/presentation/pages/history/history_page.dart' as _i2;
import 'package:towarito/presentation/pages/home/home_page.dart' as _i3;
import 'package:towarito/presentation/pages/menu/menu_page.dart' as _i4;
import 'package:towarito/presentation/pages/product/product_page.dart' as _i5;
import 'package:towarito/presentation/pages/products/products_page.dart' as _i6;
import 'package:towarito/presentation/pages/scanner/scanner_page.dart' as _i7;
import 'package:towarito/presentation/pages/session/session_page.dart' as _i8;
import 'package:towarito/presentation/pages/sessions/sessions_page.dart' as _i9;

abstract class $AppRouter extends _i10.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    DashboardRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.DashboardPage(),
      );
    },
    HistoryRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HistoryPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomePage(),
      );
    },
    MenuRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.MenuPage(),
      );
    },
    ProductRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProductRouteArgs>(
          orElse: () => ProductRouteArgs(
              initialProductId: pathParams.optString('initialProductId')));
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.ProductPage(
          key: args.key,
          initialProductId: args.initialProductId,
        ),
      );
    },
    ProductsRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.ProductsPage(),
      );
    },
    ScannerRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.ScannerPage(),
      );
    },
    SessionRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SessionRouteArgs>(
          orElse: () =>
              SessionRouteArgs(sessionId: pathParams.optString('sessionId')));
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.SessionPage(
          key: args.key,
          sessionId: args.sessionId,
        ),
      );
    },
    SessionsRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.SessionsPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.DashboardPage]
class DashboardRoute extends _i10.PageRouteInfo<void> {
  const DashboardRoute({List<_i10.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HistoryPage]
class HistoryRoute extends _i10.PageRouteInfo<void> {
  const HistoryRoute({List<_i10.PageRouteInfo>? children})
      : super(
          HistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'HistoryRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i10.PageRouteInfo<void> {
  const HomeRoute({List<_i10.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i4.MenuPage]
class MenuRoute extends _i10.PageRouteInfo<void> {
  const MenuRoute({List<_i10.PageRouteInfo>? children})
      : super(
          MenuRoute.name,
          initialChildren: children,
        );

  static const String name = 'MenuRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ProductPage]
class ProductRoute extends _i10.PageRouteInfo<ProductRouteArgs> {
  ProductRoute({
    _i11.Key? key,
    String? initialProductId,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          ProductRoute.name,
          args: ProductRouteArgs(
            key: key,
            initialProductId: initialProductId,
          ),
          rawPathParams: {'initialProductId': initialProductId},
          initialChildren: children,
        );

  static const String name = 'ProductRoute';

  static const _i10.PageInfo<ProductRouteArgs> page =
      _i10.PageInfo<ProductRouteArgs>(name);
}

class ProductRouteArgs {
  const ProductRouteArgs({
    this.key,
    this.initialProductId,
  });

  final _i11.Key? key;

  final String? initialProductId;

  @override
  String toString() {
    return 'ProductRouteArgs{key: $key, initialProductId: $initialProductId}';
  }
}

/// generated route for
/// [_i6.ProductsPage]
class ProductsRoute extends _i10.PageRouteInfo<void> {
  const ProductsRoute({List<_i10.PageRouteInfo>? children})
      : super(
          ProductsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProductsRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i7.ScannerPage]
class ScannerRoute extends _i10.PageRouteInfo<void> {
  const ScannerRoute({List<_i10.PageRouteInfo>? children})
      : super(
          ScannerRoute.name,
          initialChildren: children,
        );

  static const String name = 'ScannerRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i8.SessionPage]
class SessionRoute extends _i10.PageRouteInfo<SessionRouteArgs> {
  SessionRoute({
    _i11.Key? key,
    String? sessionId,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          SessionRoute.name,
          args: SessionRouteArgs(
            key: key,
            sessionId: sessionId,
          ),
          rawPathParams: {'sessionId': sessionId},
          initialChildren: children,
        );

  static const String name = 'SessionRoute';

  static const _i10.PageInfo<SessionRouteArgs> page =
      _i10.PageInfo<SessionRouteArgs>(name);
}

class SessionRouteArgs {
  const SessionRouteArgs({
    this.key,
    this.sessionId,
  });

  final _i11.Key? key;

  final String? sessionId;

  @override
  String toString() {
    return 'SessionRouteArgs{key: $key, sessionId: $sessionId}';
  }
}

/// generated route for
/// [_i9.SessionsPage]
class SessionsRoute extends _i10.PageRouteInfo<void> {
  const SessionsRoute({List<_i10.PageRouteInfo>? children})
      : super(
          SessionsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SessionsRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}
