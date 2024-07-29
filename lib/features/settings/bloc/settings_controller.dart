import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shelf_guardian/service/product_service.dart';
import 'package:shelf_guardian/service/user_service.dart';

/// Abstract class representing the settings controller
abstract class SettingsController {
  /// Method to open notification settings
  Future<void> openNotification();

  /// Method to save settings
  void saveSettings();
}

/// Abstract class representing the state of settings
abstract class SettingsState {}

/// State representing loading state of settings
class SettingsStateLoading implements SettingsState {
  const SettingsStateLoading();
}

/// State representing loaded settings with required parameters
class SettingsStateLoaded implements SettingsState {
  final bool notifications;
  final int summaryValue;
  final int summaryItems;
  final String email;

  const SettingsStateLoaded({
    required this.notifications,
    required this.summaryValue,
    required this.summaryItems,
    required this.email,
  });
}

/// Controller class for managing settings, extends Cubit to manage state
class SettingsControllerCubit extends Cubit<SettingsState>
    implements SettingsController {
  final products = ProductService.create();
  final auth = UserService.create();

  /// Constructor to initialize the state to loading and start initialization
  SettingsControllerCubit() : super(const SettingsStateLoading()) {
    unawaited(init());
  }

  /// Method to initialize settings from shared preferences and services
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final notifications = prefs.getBool('notifications') ?? false;
    final summaryValue = await products.getSummaryValue();
    final summaryItems = await products.getCount();
    emit(SettingsStateLoaded(
      notifications: notifications,
      summaryValue: summaryValue,
      summaryItems: summaryItems,
      email: auth.getUserEmail(),
    ));
  }

  /// Opens the app's notification settings
  @override
  Future<void> openNotification() async {
    AppSettings.openAppSettings(type: AppSettingsType.notification);
  }

  /// Saves the current settings to shared preferences
  @override
  void saveSettings() async {
    if (state is! SettingsStateLoaded) {
      return;
    }
    final currentState = state as SettingsStateLoaded;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications', currentState.notifications);
  }
}
