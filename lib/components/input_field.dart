import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shelf_guardian/common/theme.dart';

class InputField extends StatelessWidget {
  final String name;
  final String? value;
  final IconData? icon;
  final bool? enabled;
  final void Function()? onIconTap;
  final TextEditingController? controller;

  const InputField(
      {super.key,
      required this.name,
      this.value,
      this.icon,
      this.enabled = true,
      this.onIconTap,
      this.controller});

  @override
  Widget build(BuildContext context) {
    controller ?? TextEditingController(text: value);

    return Container(
      // height: 50,
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
                  child: TextField(
                style: ShelfGuardianTextStyles.body1,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10, right: 10),
                  border: InputBorder.none,
                ),
                controller: controller,
                enabled: enabled,
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
