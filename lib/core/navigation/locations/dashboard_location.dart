import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:towarito/presentation/pages/pages.dart';

class DashboardLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/dashboard'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        const BeamPage(
          key: ValueKey('dashboard'),
          title: 'Dashboard',
          type: BeamPageType.noTransition,
          child: DashboardPage(),
        ),
      ];
}
