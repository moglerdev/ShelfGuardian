import 'package:flutter/material.dart';

class CheckBoxWidget extends StatefulWidget {
  final bool isChecked;
  final void Function(bool?) onChanged;

  const CheckBoxWidget(
      {super.key, required this.isChecked, required this.onChanged});

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(value: widget.isChecked, onChanged: widget.onChanged);
  }
}
