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

class SettingsPageView extends StatelessWidget {
  const SettingsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsControllerCubit, SettingsState>(
        builder: (context, state) {
      if (state is! SettingsStateLoaded) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListView(children: [
        InputField(
            name: "User",
            controller: TextEditingController(text: state.email),
            icon: FontAwesomeIcons.arrowRightFromBracket,
            onIconTap: () {
              context.read<AuthControllerCubit>().signOut();
              context.go(NavigationServiceRoutes.signInRouteUri);
            },
            enabled: false),
        SettingsItemDescriptional(
            name: "Produkte",
            description: "Hier sehen sie die Anzahl "
                "der Produkte in ihrem Inventar",
            value: "${state.summaryItems}"),
        SettingsItemDescriptional(
            name: "Inventar Wert",
            description:
                "Hier wird der gesamte Warenwert ihres Inventars angegeben",
            value: "${state.summaryValue / 100} €"),
        SettingsItemCheckbox(
          name: "Benachrichtigung",
          description: "Wollen sie von uns Benachrichtigungen erhalten?"
              "\n Bspw. Produkte, die bald MHD erreichen.",
          onSelectChanged: (selected) {
            context.read<SettingsControllerCubit>().openNotification();
          },
          isSelected: state.notifications,
        ),
        const SizedBox(height: 100),
      ]);
    });
  }
}
