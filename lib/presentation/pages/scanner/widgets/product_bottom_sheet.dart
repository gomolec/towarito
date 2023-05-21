import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/sheet_dragable_indicator.dart';
import '../bloc/product_sheet_bloc.dart';
import 'widgets.dart';

class ProductBottomSheet extends StatelessWidget {
  const ProductBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ProductBottomSheetView();
  }
}

class ProductBottomSheetView extends StatelessWidget {
  const ProductBottomSheetView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SheetDragableIndicator(),
        SizedBox(
          height: 296.0,
          child: BlocConsumer<ProductSheetBloc, ProductSheetState>(
            listener: (context, state) {
              if (state.status == ProductSheetStatus.failure) {
                AutoRouter.of(context).pop();
              }
            },
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              if (state.status == ProductSheetStatus.found) {
                return SheetProductFoundBody(theme: theme);
              }
              if (state.status == ProductSheetStatus.notFound) {
                return SheetProductNotFoundBody(theme: theme);
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ],
    );
  }
}
