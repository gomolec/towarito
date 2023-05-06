import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:towarito/core/navigation/locations/locations.dart';

import '../../../core/navigation/beamer.dart';
import '../../../injection_container.dart';
import 'widgets/app_navigation_bar.dart';

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
    return Scaffold(
      body: Beamer(
        key: sl<AppBeamer>().beamerKey,
        routerDelegate: sl<AppBeamer>().homeDelegate,
      ),
      bottomNavigationBar: const AppNavigationBar(),
    );
  }
}
