import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shelf_guardian/features/auth/bloc/auth_controller.dart';
import 'package:shelf_guardian/common/routes_service.dart';
import 'package:shelf_guardian/components/input_field.dart';
import 'package:shelf_guardian/features/settings/components/settings_item_checkbox.dart';
import 'package:shelf_guardian/features/settings/components/settings_item_descriptional.dart';
import 'package:shelf_guardian/features/settings/bloc/settings_controller.dart';

/// A view for displaying and managing settings.
///
/// Uses [BlocBuilder] to listen to changes in the [SettingsControllerCubit] state.
class SettingsPageView extends StatelessWidget {
  const SettingsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsControllerCubit, SettingsState>(
      builder: (context, state) {
        // Show a loading indicator while the settings are being loaded
        if (state is! SettingsStateLoaded) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // Display the settings when they are loaded
        return ListView(
          children: [
            // Input field displaying the user's email, with a sign-out icon
            InputField(
              name: "User",
              controller: TextEditingController(text: state.email),
              icon: FontAwesomeIcons.arrowRightFromBracket,
              onIconTap: () {
                context.read<AuthControllerCubit>().signOut();
                context.go(NavigationServiceRoutes.signInRouteUri);
              },
              enabled: false,
            ),
            // Descriptional item showing the number of products
            SettingsItemDescriptional(
              name: "Produkte",
              description:
                  "Hier sehen sie die Anzahl der Produkte in ihrem Inventar",
              value: "${state.summaryItems}",
            ),
            // Descriptional item showing the inventory value
            SettingsItemDescriptional(
              name: "Inventar Wert",
              description:
                  "Hier wird der gesamte Warenwert ihres Inventars angegeben",
              value: "${state.summaryValue / 100} €",
            ),
            // Checkbox item for notifications
            SettingsItemCheckbox(
              name: "Benachrichtigung",
              description: "Wollen sie von uns Benachrichtigungen erhalten?"
                  "\nBspw. Produkte, die bald MHD erreichen.",
              onSelectChanged: (selected) {
                context.read<SettingsControllerCubit>().openNotification();
              },
              isSelected: state.notifications,
            ),
            const SizedBox(height: 100),
          ],
        );
      },
    );
  }
}
