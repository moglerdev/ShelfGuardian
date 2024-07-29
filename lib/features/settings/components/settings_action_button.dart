import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shelf_guardian/components/icon_button.dart';
import 'package:shelf_guardian/common/routes_service.dart';
import 'package:shelf_guardian/features/settings/bloc/settings_controller.dart';

/// A StatelessWidget that represents an action button for settings.
/// It uses BlocBuilder to rebuild the UI based on the state of SettingsControllerCubit.
class SettingsActionButton extends StatelessWidget {
  const SettingsActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsControllerCubit, SettingsState>(
      builder: (context, state) {
        // Cancel button that navigates to the home route when pressed
        Widget cancelBtn = SGIconButton(
          icon: FontAwesomeIcons.squareXmark,
          onPressed: () {
            context.go(NavigationServiceRoutes.homeRouteUri);
          },
        );

        // Save button that saves the settings and navigates to the home route when pressed
        Widget saveBtn = SGIconButton(
          size: 50,
          icon: FontAwesomeIcons.floppyDisk,
          onPressed: () {
            context.read<SettingsControllerCubit>().saveSettings();
            context.go(NavigationServiceRoutes.homeRouteUri);
          },
        );

        // Layout the buttons in a row with spacers for alignment
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
      },
    );
  }
}
