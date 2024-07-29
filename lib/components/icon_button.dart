import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shelf_guardian/common/theme.dart';

/// A custom icon button widget for Shelf Guardian.
///
/// This widget displays an icon button with customizable properties such as the icon, size, and disabled state.
/// It is built on top of the [IconButton] widget from the Flutter framework.
class SGIconButton extends StatelessWidget {
  final IconData icon;
  final void Function() onPressed;
  final double size;
  final bool disabled;

  /// Creates a new [SGIconButton] instance.
  ///
  /// The [icon] parameter specifies the icon to be displayed on the button.
  /// The [onPressed] parameter is a callback function that will be called when the button is pressed.
  /// The [size] parameter specifies the size of the button.
  /// The [disabled] parameter indicates whether the button is disabled or not.
  const SGIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 35,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    var style = disabled
        ? ShelfGuardianButtonStyles.buttonDisabled
        : ShelfGuardianButtonStyles.buttonEnabled;
    style = style.copyWith(
        fixedSize: WidgetStateProperty.all(Size(size + 20, size + 20)));
    return IconButton(
      iconSize: size,
      style: style,
      icon: FaIcon(
        icon,
        shadows: const [
          Shadow(
            color: ShelfGuardianColors.button,
            offset: Offset(0, 2),
            blurRadius: 10,
          )
        ],
      ),
      onPressed: disabled ? () {} : onPressed,
    );
  }
}
