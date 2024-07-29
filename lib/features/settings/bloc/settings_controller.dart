import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shelf_guardian/service/product_service.dart';
import 'package:shelf_guardian/service/user_service.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class SettingsController {
  Future<void> openNotification();

  void saveSettings();
}

abstract class SettingsState {}

class SettingsStateLoading implements SettingsState {
  const SettingsStateLoading();
}

class SettingsStateLoaded implements SettingsState {
  final bool notifications;
  final int summaryValue;
  final int summaryItems;
  final String email;

  const SettingsStateLoaded(
      {required this.notifications,
      required this.summaryValue,
      required this.summaryItems,
      required this.email});
}

class SettingsControllerCubit extends Cubit<SettingsState>
    implements SettingsController {
  final products = ProductService.create();
  final auth = UserService.create();

  SettingsControllerCubit() : super(const SettingsStateLoading()) {
    unawaited(init());
  }

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final notifications = prefs.getBool('notifications') ?? false;
    final summaryValue = await products.getSummaryValue();
    final summaryItems = await products.getCount();
    emit(SettingsStateLoaded(
        notifications: notifications,
        summaryValue: summaryValue,
        summaryItems: summaryItems,
        email: auth.getUserEmail()));
  }

  @override
  Future<void> openNotification() async {
    AppSettings.openAppSettings(type: AppSettingsType.notification);
  }

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
