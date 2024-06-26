import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
  static const storage = FlutterSecureStorage();

  SettingsControllerCubit() : super(const SettingsState(notifications: false)){
    unawaited(init());
  }

  Future<SettingsControllerCubit> init() async {
    final cubit = SettingsControllerCubit();
    final notificationsStr = await storage.read(key: 'notifications');
    final notifications = notificationsStr == 'true';
    emit(SettingsState(notifications: notifications));
    return cubit;
  }

  @override
  void toggleNotifications() {
    emit(SettingsState(notifications: !state.notifications));
  }

  @override
  void saveSettings() async {
    await storage.write(
        key: 'notifications',
        value: state.notifications.toString());
  }
}
