import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/features/auth/bloc/auth_state.dart';
import 'package:shelf_guardian/service/user_service.dart';

/// The abstract class that defines the contract for an authentication controller.
abstract class AuthController {
  /// Signs in the user with the provided email and password.
  Future<bool> signIn(String email, String password);

  /// Signs up the user with the provided email and password.
  Future<bool> signUp(String email, String password);

  /// Resets the password for the user with the provided email.
  Future<bool> resetPassword(String email);

  /// Signs out the current user.
  Future<bool> signOut();

  /// Returns the email of the currently signed-in user.
  String getUserEmail();
}

/// The implementation of the [AuthController] using the [Cubit] state management.
class AuthControllerCubit extends Cubit<AuthenticationState>
    implements AuthController {
  final service = UserService.create();

  /// Creates an instance of [AuthControllerCubit].
  AuthControllerCubit() : super(const UnauthenticatedState()) {
    if (service.isSignedIn()) {
      emit(const AuthenticatedState());
    } else {
      unawaited(initSession());
    }
  }

  /// Initializes the user session.
  Future<void> initSession() async {
    emit(const AuthenticatingState());
    try {
      if (await service.restoreSession()) {
        emit(const AuthenticatedState());
      } else {
        emit(const UnauthenticatedState());
      }
    } catch (e) {
      emit(const UnauthenticatedState());
      rethrow;
    }
  }

  @override
  Future<bool> signIn(String email, String password) async {
    emit(const AuthenticatingState());
    try {
      if (await service.signIn(email, password)) {
        emit(const AuthenticatedState());
        return true;
      }
    } catch (e) {
      emit(const UnauthenticatedState());
      rethrow;
    }
    emit(const UnauthenticatedState());
    return false;
  }

  @override
  Future<bool> resetPassword(String email) async {
    return service.resetPassword(email);
  }

  @override
  Future<bool> signUp(String email, String password) async {
    emit(const AuthenticatingState());
    try {
      if (await service.signUp(email, password)) {
        emit(const AuthenticatedState());
        return true;
      }
    } catch (e) {
      emit(const UnauthenticatedState());
      rethrow;
    }
    emit(const UnauthenticatedState());
    return false;
  }

  @override
  Future<bool> signOut() async {
    emit(const UnauthenticatedState());
    return await service.signOut();
  }

  @override
  String getUserEmail() => service.getUserEmail();
}
