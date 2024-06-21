import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/product/bloc/product_state.dart';

abstract class SettingsController {
  bool toggleNotifications(bool b);
  void logout();
}

class SettingsControllerCubit extends Cubit<ProductListState>
    implements SettingsController {
  SettingsControllerCubit() : super(ProductListEmpty());

  @override
  bool toggleNotifications(bool b) {
    //TODO: implement Notifications
    print("TODO: implement Notifications");
    return b;
  }

  @override
  void logout() {
    //TODO: implement logout
    print("TODO: implement logout");
  }
}
