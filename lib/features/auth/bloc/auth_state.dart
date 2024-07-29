import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/features/auth/bloc/auth_controller.dart';

/// Abstract class representing the state of authentication.
abstract class AuthenticationState {
  const AuthenticationState();

  /// Returns the current [AuthenticationState] from the given [BuildContext].
  static AuthenticationState of(BuildContext context) {
    return context.read<AuthControllerCubit>().state;
  }
}

/// Represents the state when authentication is in progress.
class AuthenticatingState extends AuthenticationState {
  const AuthenticatingState() : super();
}

/// Represents the state when authentication is successful.
class AuthenticatedState extends AuthenticationState {
  const AuthenticatedState() : super();
}

/// Represents the state when authentication is not successful.
class UnauthenticatedState extends AuthenticationState {
  const UnauthenticatedState() : super();
}
