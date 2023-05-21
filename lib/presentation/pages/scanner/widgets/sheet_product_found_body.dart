import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/quantity_buttons.dart';
import '../bloc/product_sheet_bloc.dart';
import 'widgets.dart';

class SheetProductFoundBody extends StatelessWidget {
  final ThemeData theme;

  const SheetProductFoundBody({
    super.key,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProductSheetBloc>();
    return BlocBuilder<ProductSheetBloc, ProductSheetState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SheetProductTile(
              product: state.product!,
              theme: theme,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: QuantityButtons(
                initialQuantity: state.product!.quantity,
                initialTargetQuantity: state.product!.targetQuantity,
                setQuantity: (value) =>
                    bloc.add(ProductSheetQuantityChanged(value)),
                setTargetQuantity: (value) =>
                    bloc.add(ProductSheetTargetQuantityChanged(value)),
                theme: theme,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 24.0,
                top: 8.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: FilledButton.tonalIcon(
                      onPressed: state.didChanged
                          ? () => bloc.add(const ProductSheetChangesSaved())
                          : null,
                      icon: const Icon(Icons.save_alt_rounded),
                      label: const Text("Zapisz"),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: FilledButton.tonalIcon(
                      onPressed: () =>
                          bloc.add(const ProductSheetBookmarkingChanged()),
                      icon: Icon(state.product!.bookmarked
                          ? Icons.flag
                          : Icons.flag_outlined),
                      label: Text(
                          state.product!.bookmarked ? "Odflaguj" : "Oflaguj"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
