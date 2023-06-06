import 'package:flutter/material.dart';

import 'widgets.dart';

class ImportSummaryView extends StatelessWidget {
  const ImportSummaryView({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
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
                          title: "2 produkty",
                          subtitle: "pomyślnie zaimportowane",
                          theme: theme,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: ImportSummaryCard(
                          icon: const Icon(Icons.done_rounded),
                          iconBackgroundColor: theme.colorScheme.primary,
                          title: "1 produkty",
                          subtitle: "nieudanie zaimportowane",
                          theme: theme,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const ImportBottomBar()
      ],
    );
  }
}
