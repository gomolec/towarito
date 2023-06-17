import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/import_bloc.dart';
import 'import_bottom_bar.dart';

class UploadFileView extends StatelessWidget {
  const UploadFileView({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImportBloc, ImportState>(
      builder: (context, state) {
        if (state is! ImportFileUploading) {
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
                          "Wybierz plik do zaimportowania",
                          style: theme.textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: state.instructionsText
                              .map((e) => TextSpan(
                                    text: e.text,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                        color: e.isHighlighted
                                            ? theme.colorScheme.primary
                                            : null),
                                  ))
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      InkWell(
                        onTap: () {
                          context
                              .read<ImportBloc>()
                              .add(const ImportFileSelectStarted());
                        },
                        customBorder: const CircleBorder(),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: theme.colorScheme.outline),
                          ),
                          padding: const EdgeInsets.all(48.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              () {
                                if (state.fileUploadStatus ==
                                    FileUploadStatus.initial) {
                                  return Icon(
                                    Icons.download_rounded,
                                    color: theme.colorScheme.primary,
                                    size: 72.0,
                                  );
                                }
                                if (state.fileUploadStatus ==
                                    FileUploadStatus.success) {
                                  return Icon(
                                    Icons.task_rounded,
                                    color: theme.colorScheme.primary,
                                    size: 72.0,
                                  );
                                }
                                if (state.fileUploadStatus ==
                                    FileUploadStatus.error) {
                                  return Icon(
                                    Icons.error,
                                    color: theme.colorScheme.error,
                                    size: 72.0,
                                  );
                                }
                                if (state.fileUploadStatus ==
                                    FileUploadStatus.initial) {
                                  return Icon(
                                    Icons.download_rounded,
                                    color: theme.colorScheme.primary,
                                    size: 72.0,
                                  );
                                }
                                return const SizedBox.square(
                                  dimension: 72.0,
                                  child: CircularProgressIndicator(),
                                );
                              }(),
                              Text(
                                state.fileUploadStatus ==
                                        FileUploadStatus.success
                                    ? state.selectedFileName
                                    : "Wybierz plik",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
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
            ImportBottomBar(
              buttonText: "Przejdź dalej",
              progress: state.progress,
              onTap: state.fileUploadStatus == FileUploadStatus.success
                  ? () => context
                      .read<ImportBloc>()
                      .add(const ImportFileUploadEnded())
                  : null,
            )
          ],
        );
      },
    );
  }
}
