import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/auth/bloc/auth_state.dart';
import 'package:shelf_guardian/supabase.dart';

abstract class AuthController {
  Future<bool> login(String email, String password);

  Future<bool> logout();
}

class AuthControllerCubit extends Cubit<AuthenticationState>
    implements AuthController {
  AuthControllerCubit() : super(const Unauthenticated());

  @override
  Future<bool> login(String email, String password) async {
    final client = SupabaseClientInstance.supabaseClient;
    final response = await client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user == null) {
      return false;
    }

    emit(Authenticated(response.user!));
    return true;
  }

  @override
  Future<bool> logout() async {
    emit(const Unauthenticated());
    return true;
  }
}
