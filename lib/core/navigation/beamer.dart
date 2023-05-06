import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../../presentation/pages/pages.dart';
import 'locations/locations.dart';

class AppBeamer {
  final _beamerKey = GlobalKey<BeamerState>();

  GlobalKey<BeamerState> get beamerKey => _beamerKey;

  final _rootDelegate = BeamerDelegate(
    initialPath: '/dashboard',
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '*': (context, state, data) => const HomePage(),
      },
    ),
  );

  BeamerDelegate get rootDelegate => _rootDelegate;

  final _homeDelegate = BeamerDelegate(
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [
        DashboardLocation(),
        ProductsLocation(),
        ScannerLocation(),
        HistoryLocation(),
        MenuLocation(),
      ],
    ),
  );

  BeamerDelegate get homeDelegate => _homeDelegate;
}
