import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/auth/bloc/auth_controller.dart';

abstract class AuthenticationState {
  const AuthenticationState();

  static AuthenticationState of(BuildContext context) {
    return context.read<AuthControllerCubit>().state;
  }
}

class AuthenticatingState extends AuthenticationState {
  const AuthenticatingState() : super();
}

class AuthenticatedState extends AuthenticationState {
  const AuthenticatedState() : super();
}

class UnauthenticatedState extends AuthenticationState {
  const UnauthenticatedState() : super();
}
