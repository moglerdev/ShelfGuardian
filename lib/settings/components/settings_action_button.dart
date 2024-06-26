import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shelf_guardian/components/button.dart';
import 'package:shelf_guardian/common/routes_service.dart';
import 'package:shelf_guardian/settings/bloc/settings_controller.dart';

class SettingsActionButton extends StatelessWidget {
  const SettingsActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsControllerCubit, SettingsState>(
        builder: (context, state) {
      Widget cancelBtn = SGIconButton(
        icon: FontAwesomeIcons.ban,
        onPressed: () {
          context.go(NavigationServiceRoutes.homeRouteUri);
        },
      );
      Widget saveBtn = SGIconButton(
        size: 50,
        icon: FontAwesomeIcons.floppyDisk,
        onPressed: () {
          context.read<SettingsControllerCubit>().saveSettings();
          context.go(NavigationServiceRoutes.homeRouteUri);
        },
      );
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(flex: 1),
          const SizedBox(width: 50),
          const Spacer(flex: 1),
          saveBtn,
          const Spacer(flex: 1),
          cancelBtn,
          const Spacer(flex: 1),
        ],
      );
    });
  }
}
