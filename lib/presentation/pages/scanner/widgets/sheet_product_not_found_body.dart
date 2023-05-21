import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app/app_scaffold_messager.dart';
import '../../../../core/navigation/app_router.dart';
import '../../../../injection_container.dart';
import '../bloc/product_sheet_bloc.dart';

class SheetProductNotFoundBody extends StatelessWidget {
  final ThemeData theme;

  const SheetProductNotFoundBody({super.key, required this.theme, S});

  @override
  Widget build(BuildContext context) {
    final code = context.read<ProductSheetBloc>().state.code;
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 8.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Nie znaleziono produktu",
            style: theme.textTheme.headlineSmall,
          ),
          Text(
            "Produkt z tym kodem nie znajduje się w bazie, spróbuj zeskanować ponownie lub utworzyć nowy przy użyciu przycisku na dole.",
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: theme.colorScheme.outline,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Icon(
                    Icons.link_rounded,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Expanded(
                  child: SelectableText(
                    code,
                    style: theme.textTheme.titleMedium,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
                InkWell(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: code)).then((_) {
                      sl<AppScaffoldMessager>()
                          .showSnackbar(message: "Kod został skopiowany");
                    });
                  },
                  child: Container(
                    height: 40.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondaryContainer,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 8.0,
                    ),
                    child: Text(
                      "Kopiuj",
                      style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.onSecondaryContainer),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 24.0,
              top: 8.0,
            ),
            child: FilledButton.tonalIcon(
              onPressed: () => AutoRouter.of(context).root.navigate(
                    ProductRoute(productCode: code),
                  ),
              icon: const Icon(Icons.add_rounded),
              label: const Text("Utwórz nowy produkt"),
            ),
          ),
        ],
      ),
    );
  }
}
