import 'package:flutter/material.dart';
import 'package:shelf_guardian/common/theme.dart';

/// A custom text button widget for Shelf Guardian.
class SGTextButton extends StatelessWidget {
  final String buttonText;
  final void Function() onPressed;
  final double size;
  final bool disabled;

  /// Creates a new instance of [SGTextButton].
  ///
  /// The [buttonText] parameter is required and specifies the text to be displayed on the button.
  /// The [onPressed] parameter is required and specifies the callback function to be called when the button is pressed.
  /// The [size] parameter specifies the size of the button. The default value is 35.
  /// The [disabled] parameter specifies whether the button is disabled. The default value is false.
  const SGTextButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.size = 35,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ShelfGuardianColors.button,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(10),
        ),
        onPressed: () {
          onPressed();
        },
        child: Center(
          child: Text(
            buttonText,
            style: ShelfGuardianTextStyles.body1,
          ),
        ),
      ),
    );
  }
}
