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
    if (await service.restoreSession()) {
      emit(const AuthenticatedState());
    } else {
      emit(const UnauthenticatedState());
    }
  }

  @override
  Future<bool> signIn(String email, String password) async {
    emit(const AuthenticatingState());
    final result = await service.signIn(email, password);
    if (result) {
      emit(const AuthenticatedState());
    }
    return result;
  }

  @override
  Future<bool> resetPassword(String email) async {
    return service.resetPassword(email);
  }

  @override
  Future<bool> signUp(String email, String password) async {
    emit(const AuthenticatingState());
    final result = await service.signUp(email, password);
    if (result) {
      emit(const AuthenticatedState());
    } else {
      emit(const UnauthenticatedState());
    }
    return result;
  }

  @override
  Future<bool> signOut() async {
    emit(const UnauthenticatedState());
    final result = await service.signOut();
    return result;
  }

  @override
  String getUserEmail() => service.getUserEmail();
}
