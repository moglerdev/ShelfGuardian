import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final iconStyle = ButtonStyle(
  shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
  backgroundColor: const WidgetStatePropertyAll(Color(0xFF8367C7)),
  iconColor: const WidgetStatePropertyAll(Color(0xFFFFFFFF)),
);

class SGIconButton extends StatelessWidget {
  final IconData icon;
  final void Function() onPressed;
  final double size;
//
  const SGIconButton(
      {super.key, required this.icon, required this.onPressed, this.size = 35});
//
  @override
  Widget build(BuildContext context) {
    var style = iconStyle.copyWith(
        fixedSize: WidgetStateProperty.all(Size(size + 20, size + 20)));
    return IconButton(
      iconSize: size,
      style: style,
      icon: FaIcon(
        icon,
        shadows: const [
          Shadow(
            color: Color.fromARGB(110, 0, 0, 0),
            offset: Offset(0, 2),
            blurRadius: 10,
          )
        ],
      ),
      onPressed: onPressed,
    );
  }
}
