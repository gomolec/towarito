import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/session_bloc.dart';

class UseRemoteDataField extends StatelessWidget {
  const UseRemoteDataField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SessionBloc>().state;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "BETA - tylko sklep Krukam",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
              Text(
                "Pobieraj dane ze strony internetowej",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                "Funkcja pobiera z bazy danych sklepu zdjęcie i inne parametry produktów",
                maxLines: 3,
                overflow: TextOverflow.clip,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
        Switch(
          key: const Key('newSessionView_downloadUrls_switch'),
          value: state.useRemoteData,
          activeColor: Theme.of(context).colorScheme.primary,
          onChanged: (value) {
            context
                .read<SessionBloc>()
                .add(SessionUseRemoteDataChanged(useRemoteData: value));
          },
        ),
      ],
    );
  }
}
