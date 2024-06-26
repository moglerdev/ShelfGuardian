import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shelf_guardian/components/button.dart';
import 'package:shelf_guardian/product/bloc/product_state.dart';
import 'package:shelf_guardian/filter/bloc/filter_controller.dart';

class FilterActionButton extends StatelessWidget {
  const FilterActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterControllerCubit, ProductListState>(
        builder: (context, state) {
      Widget deleteFilterBtn = SGIconButton(
        icon: FontAwesomeIcons.filterCircleXmark,
        onPressed: () {
          context.read<FilterControllerCubit>().deleteFilter();
          context.pop();
        },
      );
      Widget mainBtn = SGIconButton(
        size: 50,
        icon: FontAwesomeIcons.floppyDisk,
        onPressed: () {
          context.read<FilterControllerCubit>().saveFilter();
          context.pop();
        },
      );
      Widget cancelBtn = SGIconButton(
        icon: FontAwesomeIcons.ban,
        onPressed: () {
          context.pop();
        },
      );
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(flex: 1),
          deleteFilterBtn,
          const Spacer(flex: 1),
          mainBtn,
          const Spacer(flex: 1),
          cancelBtn,
          const Spacer(flex: 1),
        ],
      );
    });
  }
}
