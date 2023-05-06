import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:towarito/presentation/pages/pages.dart';

class HistoryLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/history'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        const BeamPage(
          key: ValueKey('history'),
          title: 'History',
          type: BeamPageType.noTransition,
          child: HistoryPage(),
        ),
      ];
}
