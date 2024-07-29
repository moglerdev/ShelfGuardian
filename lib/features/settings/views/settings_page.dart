import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/features/settings/views/settings_view.dart';
import 'package:shelf_guardian/features/settings/bloc/settings_controller.dart';
import 'package:shelf_guardian/features/settings/components/settings_action_button.dart';

/// A page that displays the settings screen.
///
/// Uses [BlocProvider] to provide the [SettingsControllerCubit] to its descendants.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Create and provide the SettingsControllerCubit instance
      create: (context) => SettingsControllerCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Einstellungen'), // AppBar title
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:
            const SettingsActionButton(), // Custom action button
        body: const SettingsPageView(), // Main content of the settings page
      ),
    );
  }
}
