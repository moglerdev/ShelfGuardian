import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shelf_guardian/common/theme.dart';
import 'package:shelf_guardian/components/date_picker.dart';

/// A custom date field widget.
///
/// This widget displays a date field with an optional icon and allows the user
/// to select a date using a date picker.
class DateField extends StatelessWidget {
  final String name;
  final void Function(DateTime) setDate;
  final DateTime? date;
  final IconData? icon;
  final bool? enabled;
  final void Function()? onIconTap;

  /// Creates a new [DateField] instance.
  ///
  /// The [name] parameter is required and specifies the name of the date field.
  /// The [setDate] parameter is required and specifies the callback function
  /// to be called when the date is set. The [date] parameter is the initial
  /// date value. The [icon] parameter is an optional icon to be displayed
  /// next to the date field. The [enabled] parameter specifies whether the
  /// date field is enabled or disabled. The [onIconTap] parameter is an
  /// optional callback function to be called when the icon is tapped.
  const DateField({
    super.key,
    required this.name,
    required this.setDate,
    this.date,
    this.icon,
    this.enabled = true,
    this.onIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ShelfGuardianColors.primary,
      ),
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  ),
                ),
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
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
