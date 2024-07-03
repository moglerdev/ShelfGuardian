import 'package:flutter/material.dart';
import 'package:shelf_guardian/common/theme.dart';

class SGTextButton extends StatelessWidget {
  final String buttonText;
  final void Function() onPressed;
  final double size;
  final bool disabled;

//
  const SGTextButton(
      {super.key,
      required this.buttonText,
      required this.onPressed,
      this.size = 35,
      this.disabled = false});

//

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: ShelfGuardianColors.button,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(10)),
          onPressed: () {onPressed(); },
          child: Center(
            child: Text(buttonText,
            style: ShelfGuardianTextStyles.body1),
          ),
        ));
  }
}
