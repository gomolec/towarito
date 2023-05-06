import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:towarito/presentation/pages/pages.dart';

class ScannerLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/scanner'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        const BeamPage(
          key: ValueKey('scanner'),
          title: 'Scanner',
          type: BeamPageType.noTransition,
          child: ScannerPage(),
        ),
      ];
}
