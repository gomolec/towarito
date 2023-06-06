import 'package:flutter/material.dart';

import 'import_method_card.dart';

class SelectImportMethodView extends StatelessWidget {
  const SelectImportMethodView({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Wybierz metodę importowania",
                style: theme.textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16.0),
            ImportMethodCard(
              icon: const Icon(Icons.download_rounded),
              title: "Import z pliku CSV",
              subtitle:
                  "Importuje przy użyciu kreatora produkty z pliku o rozszerzeniu .csv, który można otrzymać eksportując arkusz kalkulacyjny.",
              onTap: () {},
              theme: theme,
            ),
            const SizedBox(height: 16.0),
            ImportMethodCard(
              icon: const Icon(Icons.download_rounded),
              title: "Import z tabeli HTML",
              subtitle:
                  "Importuje przy użyciu kreatora produkty zawarte w tabeli HTML, uprzednio skopiowanej ze strony internetowej.",
              onTap: () {},
              theme: theme,
            ),
            const SizedBox(height: 16.0),
            ImportMethodCard(
              icon: const Icon(Icons.download_rounded),
              title: "Import sesji Towarito",
              subtitle:
                  "Importuje uprzednio wyeksportowaną sesję aplikacji Towarito. Zawiera ona: informację o sesji, produkty oraz historię.",
              theme: theme,
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
