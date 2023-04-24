import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/session_bloc.dart';

class AuthorTextField extends StatelessWidget {
  const AuthorTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SessionBloc>().state;
    return TextFormField(
      key: const Key('newSessionView_author_textFormField'),
      initialValue: state.author,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Autor',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "np. Ania - magazyn",
      ),
      onChanged: (value) {
        context.read<SessionBloc>().add(SessionAuthorChanged(author: value));
      },
    );
  }
}
