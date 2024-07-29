import 'package:flutter/material.dart';
import 'package:shelf_guardian/common/theme.dart';

class SettingsItemDescriptional extends StatelessWidget {
  final String name;
  final String description;
  final String value;

  const SettingsItemDescriptional(
      {super.key,
      required this.name,
      required this.description,
      required this.value});

  @override
  Widget build(BuildContext context) {
    // when still good 5603AD
    // when expired AD0392
    // Text Color FFFFFF

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ShelfGuardianColors.primary,
      ),
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      padding: const EdgeInsets.all(10),
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
            child: Text(
              value,
              style: ShelfGuardianTextStyles.header1,
            ))
      ]),
    );
  }
}
