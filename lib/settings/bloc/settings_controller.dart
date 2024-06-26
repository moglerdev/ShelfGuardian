import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SettingsController {
  void toggleNotifications();
}

class SettingsState {
  final bool notifications;
  const SettingsState({required this.notifications});
}

class SettingsControllerCubit extends Cubit<SettingsState>
    implements SettingsController {
  SettingsControllerCubit() : super(const SettingsState(notifications: false));

  @override
  void toggleNotifications() {
    emit(SettingsState(notifications: !state.notifications));
  }
}
