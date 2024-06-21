import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/settings/views/settings_view.dart';
import 'package:shelf_guardian/settings/bloc/settings_controller.dart';
import 'package:shelf_guardian/product/bloc/product_controller.dart';
import 'package:shelf_guardian/settings/components/settings_action_button.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingsControllerCubit>(
          create: (context) => SettingsControllerCubit(),
        ),
        BlocProvider<ProductControllerCubit>(
          create: (context) => ProductControllerCubit(),
        ),
      ],
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Einstellungen'),
          ),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
          floatingActionButton: const SettingsActionButton(),
          body: const SettingsPageView()),
    );
  }
}
