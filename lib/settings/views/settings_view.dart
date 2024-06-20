import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/product/bloc/product_state.dart';
import 'package:shelf_guardian/product/bloc/product_controller.dart';
import 'package:shelf_guardian/settings/components/settings_item_checkbox.dart';
import 'package:shelf_guardian/settings/components/settings_item_descriptional.dart';
import 'package:shelf_guardian/settings/bloc/settings_controller.dart';

class SettingsPageView extends StatelessWidget {
  const SettingsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsControllerCubit, ProductListState>(
        builder: (context, state) {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SettingsItemDescriptional(
              name: "Produkte",
              description: "Hier sehen sie die Anzahl "
                  "der Produkte in ihrem Inventar",
              value: "7" ),
              SettingsItemDescriptional(
                  name: "Inventar Wert",
                  description: "Hier wird der gesamte Warenwert ihres Inventars angegeben",
                  value: "200,00€" ),
              SettingsItemCheckbox(
                  name: "Benachrichtigung",
                  description: "Wollen sie von uns Benachrichtigungen erhalten?"
                      "\n Bspw. Produkte, die bald MHD erreichen.",
                  onSelectChanged: context.toggleNotifications,
                  isSelected: true,
                  onTap: () =>)
          ]
          );
        });
  }
}
