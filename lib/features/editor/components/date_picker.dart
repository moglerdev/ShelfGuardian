import 'package:flutter/material.dart';
import 'package:moment_dart/moment_dart.dart';

/// A text field widget that allows the user to select a date using a date picker.
class DatePickerTextField extends StatefulWidget {
  final void Function(DateTime)? onDateSelected;
  final DateTime? value;

  /// Creates a [DatePickerTextField].
  ///
  /// The [value] parameter is the initial date value to display in the text field.
  /// The [onDateSelected] parameter is a callback function that will be called when a date is selected.
  const DatePickerTextField(this.value, {super.key, this.onDateSelected});

  @override
  State createState() => _DatePickerTextFieldState();
}

class _DatePickerTextFieldState extends State<DatePickerTextField> {
  final TextEditingController _dateController = TextEditingController();

  /// Opens the date picker dialog and updates the selected date in the text field.
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      widget.onDateSelected?.call(picked);
      setState(() {
        _dateController.text = Moment(picked).format("L");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _dateController.text =
        widget.value == null ? '' : Moment(widget.value!).format("L");
    return TextField(
      controller: _dateController,
      decoration: const InputDecoration(
        labelText: 'Enter Date',
      ),
      readOnly: true,
      onTap: () => _selectDate(context),
    );
  }
}
