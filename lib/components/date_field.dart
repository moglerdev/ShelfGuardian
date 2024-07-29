import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shelf_guardian/common/theme.dart';
import 'package:shelf_guardian/components/date_picker.dart';

class DateField extends StatelessWidget {
  final String name;
  final void Function(DateTime) setDate;
  final DateTime? date;
  final IconData? icon;
  final bool? enabled;
  final void Function()? onIconTap;

  const DateField(
      {super.key,
      required this.name,
      required this.date,
      required this.setDate,
      this.icon,
      this.enabled = true,
      this.onIconTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ShelfGuardianColors.primary,
      ),
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      padding: const EdgeInsets.all(10),

      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          name,
          style: ShelfGuardianTextStyles.header1,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ShelfGuardianColors.button,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: DatePicker(
                setDate: setDate,
                date: date,
              )),
              if (icon != null)
                GestureDetector(
                  onTap: () {
                    onIconTap!();
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: FaIcon(
                      icon,
                      color: ShelfGuardianColors.icon,
                    ),
                  ),
                )
            ],
          ),
        ),
      ]),
    );
  }
}
