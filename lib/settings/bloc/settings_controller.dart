import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsController {
  void toggleNotifications();

  void saveSettings();
}

class SettingsState {
  final bool notifications;

  const SettingsState({required this.notifications});
}

class SettingsControllerCubit extends Cubit<SettingsState>
    implements SettingsController {
  SettingsControllerCubit() : super(const SettingsState(notifications: false)) {
    unawaited(init());
  }

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final notifications = prefs.getBool('notifications') ?? false;
    emit(SettingsState(notifications: notifications));
  }

  @override
  void toggleNotifications() {
    emit(SettingsState(notifications: !state.notifications));
  }

  @override
  void saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('notifications', state.notifications);
  }
}
