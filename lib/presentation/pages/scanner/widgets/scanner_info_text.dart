import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/scanner_bloc.dart';

class ScannerInfoText extends StatelessWidget {
  const ScannerInfoText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.64),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      margin: const EdgeInsets.only(top: 24.0),
      child: BlocBuilder<ScannerBloc, ScannerState>(
        builder: (context, state) {
          return Text(
            (state.status == ScannerStatus.noSession)
                ? "Aby skanować musisz otworzyć sesję"
                : "Znajdz kod do zeskanowania",
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Theme.of(context).colorScheme.background),
          );
        },
      ),
    );
  }
}
