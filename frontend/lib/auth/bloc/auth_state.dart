import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/auth/bloc/auth_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthenticationState {
  final bool _isAuthenticated;

  const AuthenticationState(this._isAuthenticated);

  bool get isAuthenticated => _isAuthenticated;

  static AuthenticationState of(BuildContext context) {
    return context.read<AuthControllerCubit>().state;
  }
}

class Authenticated extends AuthenticationState {
  const Authenticated(this.user) : super(true);

  final User user;
}

class Unauthenticated extends AuthenticationState {
  const Unauthenticated() : super(false);
}
