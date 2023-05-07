// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    DashboardRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DashboardPage(),
      );
    },
    HistoryRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HistoryPage(),
      );
    },
    MenuRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MenuPage(),
      );
    },
    ProductRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProductRouteArgs>(
          orElse: () =>
              ProductRouteArgs(productId: pathParams.optString('id')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProductPage(
          key: args.key,
          productId: args.productId,
        ),
      );
    },
    ProductsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProductsPage(),
      );
    },
    ScannerRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ScannerPage(),
      );
    },
    SessionRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SessionRouteArgs>(
          orElse: () =>
              SessionRouteArgs(sessionId: pathParams.optString('id')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SessionPage(
          key: args.key,
          sessionId: args.sessionId,
        ),
      );
    },
    SessionsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SessionsPage(),
      );
    },
    DashboardRouterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DashboardRouterScreen(),
      );
    },
    HistoryRouterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HistoryRouterScreen(),
      );
    },
    HomeRouterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeRouterScreen(),
      );
    },
    MenuRouterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MenuRouterScreen(),
      );
    },
    ProductsRouterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProductsRouterScreen(),
      );
    },
    ScannerRouterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ScannerRouterScreen(),
      );
    },
    SessionsRouterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SessionsRouterScreen(),
      );
    },
  };
}

/// generated route for
/// [DashboardPage]
class DashboardRoute extends PageRouteInfo<void> {
  const DashboardRoute({List<PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HistoryPage]
class HistoryRoute extends PageRouteInfo<void> {
  const HistoryRoute({List<PageRouteInfo>? children})
      : super(
          HistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'HistoryRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MenuPage]
class MenuRoute extends PageRouteInfo<void> {
  const MenuRoute({List<PageRouteInfo>? children})
      : super(
          MenuRoute.name,
          initialChildren: children,
        );

  static const String name = 'MenuRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProductPage]
class ProductRoute extends PageRouteInfo<ProductRouteArgs> {
  ProductRoute({
    Key? key,
    String? productId,
    List<PageRouteInfo>? children,
  }) : super(
          ProductRoute.name,
          args: ProductRouteArgs(
            key: key,
            productId: productId,
          ),
          rawPathParams: {'id': productId},
          initialChildren: children,
        );

  static const String name = 'ProductRoute';

  static const PageInfo<ProductRouteArgs> page =
      PageInfo<ProductRouteArgs>(name);
}

class ProductRouteArgs {
  const ProductRouteArgs({
    this.key,
    this.productId,
  });

  final Key? key;

  final String? productId;

  @override
  String toString() {
    return 'ProductRouteArgs{key: $key, productId: $productId}';
  }
}

/// generated route for
/// [ProductsPage]
class ProductsRoute extends PageRouteInfo<void> {
  const ProductsRoute({List<PageRouteInfo>? children})
      : super(
          ProductsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProductsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ScannerPage]
class ScannerRoute extends PageRouteInfo<void> {
  const ScannerRoute({List<PageRouteInfo>? children})
      : super(
          ScannerRoute.name,
          initialChildren: children,
        );

  static const String name = 'ScannerRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SessionPage]
class SessionRoute extends PageRouteInfo<SessionRouteArgs> {
  SessionRoute({
    Key? key,
    String? sessionId,
    List<PageRouteInfo>? children,
  }) : super(
          SessionRoute.name,
          args: SessionRouteArgs(
            key: key,
            sessionId: sessionId,
          ),
          rawPathParams: {'id': sessionId},
          initialChildren: children,
        );

  static const String name = 'SessionRoute';

  static const PageInfo<SessionRouteArgs> page =
      PageInfo<SessionRouteArgs>(name);
}

class SessionRouteArgs {
  const SessionRouteArgs({
    this.key,
    this.sessionId,
  });

  final Key? key;

  final String? sessionId;

  @override
  String toString() {
    return 'SessionRouteArgs{key: $key, sessionId: $sessionId}';
  }
}

/// generated route for
/// [SessionsPage]
class SessionsRoute extends PageRouteInfo<void> {
  const SessionsRoute({List<PageRouteInfo>? children})
      : super(
          SessionsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SessionsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DashboardRouterScreen]
class DashboardRouterRoute extends PageRouteInfo<void> {
  const DashboardRouterRoute({List<PageRouteInfo>? children})
      : super(
          DashboardRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRouterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HistoryRouterScreen]
class HistoryRouterRoute extends PageRouteInfo<void> {
  const HistoryRouterRoute({List<PageRouteInfo>? children})
      : super(
          HistoryRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'HistoryRouterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeRouterScreen]
class HomeRouterRoute extends PageRouteInfo<void> {
  const HomeRouterRoute({List<PageRouteInfo>? children})
      : super(
          HomeRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRouterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MenuRouterScreen]
class MenuRouterRoute extends PageRouteInfo<void> {
  const MenuRouterRoute({List<PageRouteInfo>? children})
      : super(
          MenuRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'MenuRouterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProductsRouterScreen]
class ProductsRouterRoute extends PageRouteInfo<void> {
  const ProductsRouterRoute({List<PageRouteInfo>? children})
      : super(
          ProductsRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProductsRouterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ScannerRouterScreen]
class ScannerRouterRoute extends PageRouteInfo<void> {
  const ScannerRouterRoute({List<PageRouteInfo>? children})
      : super(
          ScannerRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'ScannerRouterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SessionsRouterScreen]
class SessionsRouterRoute extends PageRouteInfo<void> {
  const SessionsRouterRoute({List<PageRouteInfo>? children})
      : super(
          SessionsRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'SessionsRouterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
