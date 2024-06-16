import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shelf_guardian/components/button.dart';
import 'package:shelf_guardian/scanner/bloc/scanner_controller.dart';

class ScannerActionButton extends StatelessWidget {
  const ScannerActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScannerControllerCubit, ScannerState>(
        builder: (context, state) {
      List<Widget> leftBtns = [
        SGIconButton(icon: FontAwesomeIcons.gear, onPressed: () {}),
        const SizedBox(width: 10),
        SGIconButton(
          icon: FontAwesomeIcons.filter,
          onPressed: () {
            // TODO Implement filter page
            print("TODO: Implement filter page");
          },
        ),
        const SizedBox(width: 10),
      ];
      Widget mainBtn;
      List<Widget> rightBtns = [const SizedBox(width: 10)];
      rightBtns.add(SGIconButton(
        icon: FontAwesomeIcons.rectangleXmark,
        onPressed: () {},
      ));
      mainBtn = SGIconButton(
        size: 50,
        icon: FontAwesomeIcons.trash,
        onPressed: () {},
      );
      rightBtns.add(const SizedBox(width: 10));
      rightBtns.add(SGIconButton(
        icon: FontAwesomeIcons.magnifyingGlass,
        onPressed: () {},
      ));
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [...leftBtns, mainBtn, ...rightBtns],
      );
    });
  }
}
