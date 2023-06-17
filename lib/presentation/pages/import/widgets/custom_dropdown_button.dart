import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  final List<DropdownMenuItem<int?>> items;
  final void Function(dynamic)? onChanged;
  final String? labelText;
  final String? helperText;
  final bool isRequired;

  const CustomDropdownButton({
    Key? key,
    required this.items,
    this.onChanged,
    this.labelText,
    this.helperText,
    this.isRequired = false,
  }) : super(key: key);

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  dynamic _value;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int?>(
      value: _value,
      items: widget.items,
      onChanged: (value) {
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
        setState(() {
          _value = value;
        });
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: widget.labelText,
        helperText: widget.helperText ?? '',
        suffixIcon: _value != null
            ? IconButton(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                onPressed: () => setState(() => _value = null),
                icon: const Icon(Icons.clear_rounded),
              )
            : null,
      ),
      isExpanded: true,
      validator: widget.isRequired
          ? (value) {
              if (value == null) {
                return 'Pole jest wymagane';
              }
              return null;
            }
          : null,
    );
  }
}
