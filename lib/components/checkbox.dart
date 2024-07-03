import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shelf_guardian/common/theme.dart';

class SGCheckBox extends StatefulWidget {
  final void Function(bool) onSelectChanged;
  final bool isSelected;

  @override
  SGCheckBoxState createState() => SGCheckBoxState();

  const SGCheckBox(
      {super.key, required this.onSelectChanged, required this.isSelected});
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
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(10),
              minimumSize: const Size(40, 40)),
          onPressed: () {
            _onTap();
          },
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.check,
              color: widget.isSelected
                  ? ShelfGuardianColors.icon
                  : Colors.transparent,
              size: 40,
            ),
          ),
        ));
  }
}
