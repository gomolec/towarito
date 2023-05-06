import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../../../presentation/pages/pages.dart';

class MenuLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => [
        '/menu',
        '/menu/user',
        '/menu/sessions',
        '/menu/sessions/new',
        '/menu/sessions/:sessionId',
        '/menu/import',
        '/menu/export',
        '/menu/help',
        '/menu/settings',
        '/menu/clear',
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final pages = [
      const BeamPage(
        key: ValueKey('menu'),
        title: 'Menu',
        type: BeamPageType.noTransition,
        child: MenuPage(),
      ),
    ];
    if (state.uri.pathSegments.contains('sessions')) {
      pages.add(const BeamPage(
        key: ValueKey('sessions'),
        title: 'Sessions',
        type: BeamPageType.noTransition,
        child: SessionsPage(),
      ));
      if (state.uri.pathSegments.contains('new')) {
        pages.add(const BeamPage(
          key: ValueKey('session-new'),
          title: 'New session',
          type: BeamPageType.noTransition,
          child: SessionPage(),
        ));
      }
      if (state.pathParameters.containsKey('sessionId')) {
        pages.add(BeamPage(
          key: ValueKey('session-${state.pathParameters['sessionId']}'),
          title: 'Edit session',
          type: BeamPageType.noTransition,
          child: SessionPage(sessionId: state.pathParameters['sessionId']),
        ));
      }
    }
    return pages;
  }
}
