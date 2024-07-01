import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:shelf_guardian/common/theme.dart';

class DatePicker extends StatelessWidget {
  final void Function(DateTime) setDate;
  final DateTime? date;

  const DatePicker(
      {super.key, required this.setDate, required this.date});

  @override
  Widget build(BuildContext context) {
    final TextEditingController dateController = date != null
        ? TextEditingController(text: (DateFormat('dd.MM.yyyy').format(date!)))
        : TextEditingController();
    return Expanded(
        child: Container(
            margin: const EdgeInsets.only(right: 10, left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ShelfGuardianColors.button,
            ),
            child: TextField(
              style: ShelfGuardianTextStyles.body1,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 10, right: 10),
                border: InputBorder.none,
              ),
              controller: dateController,
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2024),
                  lastDate: DateTime(2124),
                );
                if (pickedDate != null) {
                  setDate(pickedDate);
                  dateController.text =
                      DateFormat('dd.MM.yyyy').format(pickedDate);
                }
              },
            )));
  }
}
