import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_bloc.dart';

class ProductNameField extends StatelessWidget {
  const ProductNameField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductBloc>().state;
    return TextFormField(
      initialValue: state.name,
      onChanged: (value) =>
          context.read<ProductBloc>().add(ProductNameChanged(value)),
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        label: Text("Nazwa produktu"),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: InputBorder.none,
        isCollapsed: true,
      ),
      maxLines: null,
      style: Theme.of(context)
          .textTheme
          .headlineMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
    );
  }
}
