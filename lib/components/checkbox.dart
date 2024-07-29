import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shelf_guardian/common/theme.dart';

/// A custom checkbox widget for Shelf Guardian.
///
/// This widget displays a checkbox button with a check icon. The checkbox can be
/// selected or deselected by tapping on it. The state of the checkbox is managed
/// internally by the widget and can be accessed using the [isSelected] property.
///
/// When the checkbox is tapped, the [onSelectChanged] callback is called with the
/// new selected state as a parameter.
class SGCheckBox extends StatefulWidget {
  /// Callback function that is called when the checkbox is tapped.
  final void Function(bool) onSelectChanged;

  /// Whether the checkbox is currently selected or not.
  final bool isSelected;

  const SGCheckBox({
    super.key,
    required this.onSelectChanged,
    required this.isSelected,
  });

  @override
  SGCheckBoxState createState() => SGCheckBoxState();
}

class SGCheckBoxState extends State<SGCheckBox> {
  void _onTap() {
    setState(() {
      widget.onSelectChanged(!widget.isSelected);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ShelfGuardianColors.button,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(10),
          minimumSize: const Size(40, 40),
        ),
        onPressed: _onTap,
        child: Center(
          child: FaIcon(
            FontAwesomeIcons.check,
            color: widget.isSelected
                ? ShelfGuardianColors.icon
                : Colors.transparent,
            size: 40,
          ),
        ),
      ),
    );
  }
}
