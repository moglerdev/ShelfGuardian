import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shelf_guardian/auth/bloc/auth_controller.dart';
import 'package:shelf_guardian/common/routes_service.dart';
import 'package:shelf_guardian/components/input_field.dart';
import 'package:shelf_guardian/product/bloc/product_controller.dart';
import 'package:shelf_guardian/settings/components/settings_item_checkbox.dart';
import 'package:shelf_guardian/settings/components/settings_item_descriptional.dart';
import 'package:shelf_guardian/settings/bloc/settings_controller.dart';

import 'package:shelf_guardian/product/bloc/product_state.dart';

class SettingsPageView extends StatelessWidget {
  const SettingsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsControllerCubit, SettingsState>(
        builder: (context, state) {
      var productController = context.watch<ProductControllerCubit>();
      var productAmmount = productController.state.getProducts().length;
      if (productController.state is ProductListLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        InputField(
            name: "User",
            value: context.watch<AuthControllerCubit>().getUserEmail(),
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
            value: "$productAmmount"),
        const SettingsItemDescriptional(
            name: "Inventar Wert",
            description:
                "Hier wird der gesamte Warenwert ihres Inventars angegeben",
            value: "XXX,XX€"),
        SettingsItemCheckbox(
          name: "Benachrichtigung",
          description: "Wollen sie von uns Benachrichtigungen erhalten?"
              "\n Bspw. Produkte, die bald MHD erreichen.",
          onSelectChanged: (selected) {
            context.read<SettingsControllerCubit>().toggleNotifications();
          },
          isSelected: state.notifications,
        )
      ]);
    });
  }
}
