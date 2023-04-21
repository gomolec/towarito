import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/navigation/router.gr.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePageView();
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        DashboardRoute(),
        ProductsRoute(),
        DashboardRoute(),
        HistoryRoute(),
        MenuRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) => NavigationBar(
        selectedIndex: tabsRouter.activeIndex,
        onDestinationSelected: (index) {
          if (index == 2) {
            context.router.navigate(const ScannerRoute());
          } else {
            tabsRouter.setActiveIndex(index);
          }
        },
        destinations: const <Widget>[
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
      ),
    );
  }
}
