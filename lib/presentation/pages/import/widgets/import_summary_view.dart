import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/import_bloc.dart';
import 'widgets.dart';

class ImportSummaryView extends StatelessWidget {
  const ImportSummaryView({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImportBloc, ImportState>(
      builder: (context, state) {
        if (state is! ImportSummary) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Importowanie zakończone",
                          style: theme.textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  "Produkty zostały pomyślnie zaimportowane do systemu Towarito. Proszę zwrócić uwagę na produkty, których import się nie powiódł.",
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      Row(
                        children: [
                          Expanded(
                            child: ImportSummaryCard(
                              icon: const Icon(Icons.done_rounded),
                              iconBackgroundColor: theme.colorScheme.primary,
                              title:
                                  "${state.successedProductsNumber} produkty",
                              subtitle: "pomyślnie zaimportowane",
                              theme: theme,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: ImportSummaryCard(
                              icon: const Icon(Icons.done_rounded),
                              iconBackgroundColor: theme.colorScheme.primary,
                              title: "${state.failedProductsNumber} produkty",
                              subtitle: "nieudanie zaimportowane",
                              theme: theme,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32.0),
                      state.errorText.isNotEmpty
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      state.errorText,
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(
                                              color: theme.colorScheme
                                                  .onSurfaceVariant),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ),
            ImportBottomBar(
              buttonText: "Zakończ",
              progress: 1,
              onTap: () => AutoRouter.of(context).pop(),
            )
          ],
        );
      },
    );
  }
}
