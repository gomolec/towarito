import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:towarito/presentation/pages/import/widgets/import_bottom_bar.dart';

import '../bloc/import_bloc.dart';
import 'custom_dropdown_button.dart';

class FileFieldMapView extends StatefulWidget {
  const FileFieldMapView({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  State<FileFieldMapView> createState() => _FileFieldMapViewState();
}

class _FileFieldMapViewState extends State<FileFieldMapView> {
  final _formKey = GlobalKey<FormState>();

  int? nameColumnIndex;
  int? codeColumnIndex;
  int? targetQuantityColumnIndex;
  int? quantityColumnIndex;
  int? noteColumnIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImportBloc, ImportState>(
      builder: (context, state) {
        if (state is! ImportFieldsMapping) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        late final List<DropdownMenuItem<int>> options = state.fileHeaders
            .mapIndexed((index, element) => DropdownMenuItem(
                  value: index,
                  child: Text(element),
                ))
            .toList();
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Przyporządkuj polą systemu Towarito odpowiadające im nagłówki twojego pliku",
                        style: widget.theme.textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomDropdownButton(
                                labelText: "Nazwa produktu",
                                helperText: "*wymagane",
                                items: options,
                                isRequired: true,
                                onChanged: (value) => nameColumnIndex = value,
                              ),
                              const SizedBox(height: 16.0),
                              CustomDropdownButton(
                                labelText: "Kod produktu",
                                helperText: "*wymagane",
                                items: options,
                                isRequired: true,
                                onChanged: (value) => codeColumnIndex = value,
                              ),
                              const SizedBox(height: 16.0),
                              CustomDropdownButton(
                                labelText: "Docelowa ilość",
                                helperText: "*wymagane",
                                items: options,
                                isRequired: true,
                                onChanged: (value) =>
                                    targetQuantityColumnIndex = value,
                              ),
                              const SizedBox(height: 16.0),
                              CustomDropdownButton(
                                labelText: "Ilość",
                                items: options,
                                onChanged: (value) =>
                                    quantityColumnIndex = value,
                              ),
                              const SizedBox(height: 16.0),
                              CustomDropdownButton(
                                labelText: "Notatka",
                                items: options,
                                onChanged: (value) => noteColumnIndex = value,
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
            ),
            ImportBottomBar(
              buttonText: "Przejdź dalej",
              progress: state.progress,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  context.read<ImportBloc>().add(
                        ImportFieldsMappingEnded(
                          nameColumnIndex: nameColumnIndex!,
                          codeColumnIndex: codeColumnIndex!,
                          targetQuantityColumnIndex: targetQuantityColumnIndex!,
                          quantityColumnIndex: quantityColumnIndex,
                          noteColumnIndex: noteColumnIndex,
                        ),
                      );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
