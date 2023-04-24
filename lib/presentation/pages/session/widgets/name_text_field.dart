import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/session_bloc.dart';

class NameTextField extends StatelessWidget {
  const NameTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SessionBloc>().state;
    return TextFormField(
      key: const Key('newSessionView_name_textFormField'),
      initialValue: state.name,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Nazwa',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "np. Dostawa magazyn",
      ),
      onChanged: (value) {
        context.read<SessionBloc>().add(SessionNameChanged(name: value));
      },
    );
  }
}
