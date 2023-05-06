import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../../../../core/navigation/beamer.dart';
import '../../../../core/navigation/locations/locations.dart';
import '../../../../injection_container.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({
    super.key,
  });

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  late BeamerDelegate _beamerDelegate;
  int _currentIndex = 0;

  void _setCurrentIndex() => setState(() {
        if (_beamerDelegate.currentBeamLocation is ProductsLocation) {
          _currentIndex = 1;
        } else if (_beamerDelegate.currentBeamLocation is ScannerLocation) {
          _currentIndex = 2;
        } else if (_beamerDelegate.currentBeamLocation is HistoryLocation) {
          _currentIndex = 3;
        } else if (_beamerDelegate.currentBeamLocation is MenuLocation) {
          _currentIndex = 4;
        } else {
          _currentIndex = 0;
        }
      });

  @override
  void initState() {
    super.initState();
    _beamerDelegate = sl<AppBeamer>().beamerKey.currentState!.routerDelegate;
    _beamerDelegate.addListener(_setCurrentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: _currentIndex,
      onDestinationSelected: (value) {
        late final String uri;
        switch (value) {
          case 1:
            uri = '/products';
            break;
          case 2:
            uri = '/scanner';
            break;
          case 3:
            uri = '/history';
            break;
          case 4:
            uri = '/menu';
            break;
          default:
            uri = '/dashboard';
        }
        _beamerDelegate.beamToNamed(uri);
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
    );
  }

  @override
  void dispose() {
    _beamerDelegate.removeListener(_setCurrentIndex);
    super.dispose();
  }
}
