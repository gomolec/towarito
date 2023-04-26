import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_bloc.dart';

class ProductNoteField extends StatelessWidget {
  const ProductNoteField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductBloc>().state;
    return TextFormField(
      initialValue: state.note,
      onChanged: (value) =>
          context.read<ProductBloc>().add(ProductNoteChanged(value)),
      decoration: const InputDecoration(
        label: Text("Zapisz tu przydatne informacje"),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: InputBorder.none,
        isCollapsed: true,
      ),
      maxLines: null,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
