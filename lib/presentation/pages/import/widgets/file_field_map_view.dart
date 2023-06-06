import 'package:flutter/material.dart';

import 'package:towarito/presentation/pages/import/widgets/import_bottom_bar.dart';

import 'custom_dropdown_button.dart';

class FileFieldMapView extends StatelessWidget {
  const FileFieldMapView({
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Przyporządkuj polą systemu Towarito odpowiadające im nagłówki twojego pliku",
                    style: theme.textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: FieldsMapForm(),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
        const ImportBottomBar(),
      ],
    );
  }
}

class FieldsMapForm extends StatefulWidget {
  const FieldsMapForm({super.key});

  @override
  State<FieldsMapForm> createState() => _FieldsMapFormState();
}

class _FieldsMapFormState extends State<FieldsMapForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: const [
          CustomDropdownButton(
            labelText: "Nazwa produktu",
            helperText: "*wymagane",
            items: [
              DropdownMenuItem(
                value: 1,
                child: Text("kolumna 1"),
              ),
              DropdownMenuItem(
                value: 2,
                child: Text("kolumna 2"),
              ),
              DropdownMenuItem(
                value: 3,
                child: Text("kolumna 3"),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          CustomDropdownButton(
            labelText: "Kod produktu",
            helperText: "*wymagane",
            items: [
              DropdownMenuItem(
                value: 1,
                child: Text("kolumna 1"),
              ),
              DropdownMenuItem(
                value: 2,
                child: Text("kolumna 2"),
              ),
              DropdownMenuItem(
                value: 3,
                child: Text("kolumna 3"),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          CustomDropdownButton(
            labelText: "Docelowa ilość",
            helperText: "*wymagane",
            items: [
              DropdownMenuItem(
                value: 1,
                child: Text("kolumna 1"),
              ),
              DropdownMenuItem(
                value: 2,
                child: Text("kolumna 2"),
              ),
              DropdownMenuItem(
                value: 3,
                child: Text("kolumna 3"),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          CustomDropdownButton(
            labelText: "Ilość",
            items: [
              DropdownMenuItem(
                value: 1,
                child: Text("kolumna 1"),
              ),
              DropdownMenuItem(
                value: 2,
                child: Text("kolumna 2"),
              ),
              DropdownMenuItem(
                value: 3,
                child: Text("kolumna 3"),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          CustomDropdownButton(
            labelText: "Notatka",
            items: [
              DropdownMenuItem(
                value: 1,
                child: Text("kolumna 1"),
              ),
              DropdownMenuItem(
                value: 2,
                child: Text("kolumna 2"),
              ),
              DropdownMenuItem(
                value: 3,
                child: Text("kolumna 3"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
