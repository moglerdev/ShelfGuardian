import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String label;
  final String value;
  final void Function(String) onChanged;

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
