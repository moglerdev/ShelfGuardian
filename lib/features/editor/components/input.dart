import 'package:flutter/material.dart';

/// A custom input widget that displays a labeled text field.
class Input extends StatelessWidget {
  final String label;
  final String value;
  final void Function(String) onChanged;

  /// Creates a new instance of the [Input] widget.
  ///
  /// The [label] parameter is the text to display as the label for the input field.
  /// The [value] parameter is the initial value of the input field.
  /// The [onChanged] parameter is a callback function that is called whenever the value of the input field changes.
  const Input({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
      ),
      controller: TextEditingController(text: value),
      onChanged: onChanged,
    );
  }
}
