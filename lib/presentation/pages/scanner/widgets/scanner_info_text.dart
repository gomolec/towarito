import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/scanner_bloc.dart';

class ScannerInfoText extends StatelessWidget {
  const ScannerInfoText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
            buildWhen: (previous, current) =>
                previous.currentSessionActive != current.currentSessionActive,
            builder: (context, state) {
              return Text(
                (state.currentSessionActive)
                    ? "Znajdz kod do zeskanowania"
                    : "Aby skanować musisz otworzyć sesję",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Theme.of(context).colorScheme.background),
              );
            },
          ),
        ),
      ],
    );
  }
}
