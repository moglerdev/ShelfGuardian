import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shelf_guardian/components/button.dart';
import 'package:shelf_guardian/product/bloc/product_state.dart';
import 'package:shelf_guardian/common/routes_service.dart';
import 'package:shelf_guardian/settings/bloc/settings_controller.dart';

class SettingsActionButton extends StatelessWidget {
  const SettingsActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsControllerCubit, ProductListState>(
        builder: (context, state) {
      Widget rightBtn = SGIconButton(
        icon: FontAwesomeIcons.ban,
        onPressed: () {
          context.push(NavigationServiceRoutes.homeRouteUri);
        },
      );
      Widget mainBtn = SGIconButton(
        size: 50,
        icon: FontAwesomeIcons.floppyDisk,
        onPressed: () {
          context.push(NavigationServiceRoutes.homeRouteUri);
        },
      );
      return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(flex: 1),
          const SizedBox(width: 50),
          const Spacer(flex: 1),
          mainBtn,
          const Spacer(flex: 1),
          rightBtn,
          const Spacer(flex: 1),
        ],
      );
    });
  }
}
