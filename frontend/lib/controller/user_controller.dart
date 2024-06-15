import 'package:flutter_bloc/flutter_bloc.dart';

class UserViewModel {
  final String name;
  final String email;

  UserViewModel({this.name = '', this.email = ''});
}

class UserController extends Cubit<UserViewModel> {
  UserController() : super(UserViewModel());
}
