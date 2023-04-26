import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_bloc.dart';

class ProductCodeField extends StatelessWidget {
  const ProductCodeField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductBloc>().state;
    return TextFormField(
      initialValue: state.code,
      onChanged: (value) =>
          context.read<ProductBloc>().add(ProductCodeChanged(value)),
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        label: Text("np. 007"),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: InputBorder.none,
        isCollapsed: true,
      ),
      maxLines: null,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
