import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/auth/bloc/auth_state.dart';
import 'package:shelf_guardian/service/user_service.dart';

abstract class AuthController {
  Future<bool> signIn(String email, String password);
  Future<bool> signUp(String email, String password);
  Future<bool> resetPassword(String email);

  Future<bool> signOut();
  String getUserEmail();
}

class AuthControllerCubit extends Cubit<AuthenticationState>
    implements AuthController {
  final service = UserService.create();

  AuthControllerCubit() : super(const UnauthenticatedState()) {
    if (service.isSignedIn()) {
      emit(const AuthenticatedState());
    } else {
      unawaited(initSession());
    }
  }

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
