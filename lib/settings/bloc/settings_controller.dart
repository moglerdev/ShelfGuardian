import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shelf_guardian/service/product_service.dart';

abstract class SettingsController {
  void toggleNotifications();

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

  const SettingsStateLoaded(
      {required this.notifications,
      required this.summaryValue,
      required this.summaryItems});
}

class SettingsControllerCubit extends Cubit<SettingsState>
    implements SettingsController {
  final products = ProductService.create();

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
        summaryItems: summaryItems));
  }

  @override
  void toggleNotifications() {
    if (state is! SettingsStateLoaded) {
      return;
    }
    final currentState = state as SettingsStateLoaded;
    emit(SettingsStateLoaded(
        notifications: !currentState.notifications,
        summaryValue: currentState.summaryValue,
        summaryItems: currentState.summaryItems));
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
