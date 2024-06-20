import 'package:flutter/material.dart';
import 'package:shelf_guardian/common/theme.dart';

class SettingsItemCheckbox extends StatelessWidget {
  final String name;
  final String description;
  final void Function(bool) onSelectChanged;
  final bool isSelected;

  const SettingsItemCheckbox(
      {super.key,
      required this.name,
      required this.description,
      required this.onSelectChanged,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    // when still good 5603AD
    // when expired AD0392
    // Text Color FFFFFF

    return GestureDetector(
        onLongPress: () {
          onSelectChanged(!isSelected);
        },
        child: Container(
          // height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ShelfGuardianColors.primary,
          ),
          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          padding: const EdgeInsets.all(10),
          // color: item.isExpired ? Color(0xFFAD0392) : Color(0xFF5603AD),
          child: Row(children: [
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: ShelfGuardianTextStyles.header1,
                ),
                Text(
                  description,
                  style: ShelfGuardianTextStyles.body1,
                ),
              ],
            )),
            Container(
                margin: const EdgeInsets.only(left: 10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ShelfGuardianColors.button,
                ),
                child: Checkbox(
                    value: isSelected,
                    onChanged: (selected) {
                      onSelectChanged(!isSelected);
                    }))
          ]),
        ));
  }
}
