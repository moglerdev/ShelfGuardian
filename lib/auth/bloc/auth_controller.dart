import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/auth/bloc/auth_state.dart';
import 'package:shelf_guardian/supabase.dart';

abstract class AuthController {
  Future<bool> signIn(String email, String password);
  Future<bool> signUp(String email, String password);
  Future<bool> resetPassword(String email);

  Future<bool> signOut();
}

class AuthControllerCubit extends Cubit<AuthenticationState>
    implements AuthController {
  AuthControllerCubit() : super(const Unauthenticated()) {
    final client = SBClient.supabaseClient;
    if (client.auth.currentUser != null) {
      emit(Authenticated(client.auth.currentUser!));
    }
  }

  @override
  Future<bool> signIn(String email, String password) async {
    final client = SBClient.supabaseClient;
    final response = await client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user == null || response.session == null) {
      return false;
    }
    await saveSession();
    emit(Authenticated(response.user!));
    return true;
  }

  @override
  Future<bool> resetPassword(String email) async {
    final client = SBClient.supabaseClient;
    client.auth.resetPasswordForEmail(email);
    return true;
  }

  @override
  Future<bool> signUp(String email, String password) async {
    final client = SBClient.supabaseClient;

    final response = await client.auth.signUp(email: email, password: password);

    if (response.user == null) {
      return false;
    }
    await saveSession();
    emit(Authenticated(response.user!));
    return true;
  }

  @override
  Future<bool> signOut() async {
    clearSession();
    emit(const Unauthenticated());
    return true;
  }
}
