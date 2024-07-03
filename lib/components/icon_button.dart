import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shelf_guardian/common/theme.dart';

class SGIconButton extends StatelessWidget {
  final IconData icon;
  final void Function() onPressed;
  final double size;
  final bool disabled;

//
  const SGIconButton(
      {super.key,
      required this.icon,
      required this.onPressed,
      this.size = 35,
      this.disabled = false});

//
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
