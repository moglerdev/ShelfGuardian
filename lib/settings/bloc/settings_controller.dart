import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/product/bloc/product_state.dart';

abstract class SettingsController {
  void toggleNotifications(bool b);
}

class SettingsControllerCubit extends Cubit<ProductListState>
    implements SettingsController {
  SettingsControllerCubit() : super(ProductListEmpty());

  @override
  void toggleNotifications(bool b) {
    //TODO: implement Notifications
  }
}
