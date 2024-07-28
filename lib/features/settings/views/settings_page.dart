import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/features/settings/views/settings_view.dart';
import 'package:shelf_guardian/features/settings/bloc/settings_controller.dart';
import 'package:shelf_guardian/features/settings/components/settings_action_button.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsControllerCubit(),
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
