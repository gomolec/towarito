import 'package:flutter/material.dart';

import 'import_bottom_bar.dart';

class UploadFileView extends StatelessWidget {
  const UploadFileView({
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
                      "Wybierz plik do zaimportowania",
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
                              "Tutaj możesz przekazać plik .csv do zaimportowania. Możesz go użyskać poprzez eksport arkusza kalkulacyjnego. ",
                          style: theme.textTheme.bodyMedium,
                        ),
                        TextSpan(
                          text:
                              "Należy zwrócić uwagę na to, że pierwszy wiersz powinien zawierać nazwy kolumn.",
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: theme.colorScheme.primary),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  InkWell(
                    onTap: () {},
                    customBorder: const CircleBorder(),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: theme.colorScheme.outline),
                      ),
                      padding: const EdgeInsets.all(48.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.download_rounded,
                            color: theme.colorScheme.primary,
                            size: 72.0,
                          ),
                          Text(
                            "Wybierz plik",
                            style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant),
                          ),
                          const SizedBox(height: 8.0),
                        ],
                      ),
                    ),
                  )
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
