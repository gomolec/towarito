import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:towarito/core/navigation/app_router.dart';

@RoutePage()
class HomeRouterScreen extends StatelessWidget {
  const HomeRouterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AutoTabsScaffold(
        routes: const [
          DashboardRouterRoute(),
          ProductsRouterRoute(),
          ScannerRouterRoute(),
          HistoryRouterRoute(),
          MenuRouterRoute(),
        ],
        bottomNavigationBuilder: (_, tabsRouter) {
          return NavigationBar(
            selectedIndex: tabsRouter.activeIndex,
            onDestinationSelected: tabsRouter.setActiveIndex,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.dashboard_outlined),
                selectedIcon: Icon(Icons.dashboard_rounded),
                label: 'Start',
              ),
              NavigationDestination(
                icon: Icon(Icons.inventory_2_outlined),
                selectedIcon: Icon(Icons.inventory_2_rounded),
                label: 'Produkty',
              ),
              NavigationDestination(
                icon: Icon(Icons.qr_code_scanner_rounded),
                label: 'Skaner',
              ),
              NavigationDestination(
                icon: Icon(Icons.history_rounded),
                label: 'Historia',
              ),
              NavigationDestination(
                icon: Icon(Icons.more_horiz_rounded),
                label: 'Więcej',
              ),
            ],
          );
        },
      ),
    );
  }
}
