import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shelf_guardian/service/notification_service.dart';
import 'package:shelf_guardian/supabase.dart';

abstract class UserService {
  Future<bool> signIn(String email, String password);
  Future<bool> signUp(String email, String password);
  Future<bool> resetPassword(String email);
  Future<bool> signOut();
  String getUserEmail();

  bool isSignedIn();

  Future<void> clearSession();
  Future<bool> restoreSession();
  Future<bool> saveSession();

  static UserService create() {
    return SupabaseUserService();
  }
}

final _storage = const FlutterSecureStorage();

class SupabaseUserService implements UserService {
  final client = SupabaseApi.client;
  final authStoreKey = "dev.mogler.sg::session";
  final notification = NotificationService.create();

  @override
  Future<bool> signIn(String email, String password) async {
    final response = await client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user == null || response.session == null) {
      return false;
    }
    await saveSession();
    return true;
  }

  @override
  bool isSignedIn() {
    return client.auth.currentUser != null;
  }

  @override
  Future<bool> signUp(String email, String password) async {
    final response = await client.auth.signUp(email: email, password: password);

    if (response.user == null) {
      return false;
    }
    await saveSession();
    return true;
  }

  @override
  Future<bool> signOut() async {
    await clearSession();
    return true;
  }

  @override
  Future<bool> resetPassword(String email) async {
    await client.auth.resetPasswordForEmail(email);
    return true;
  }

  @override
  Future<void> clearSession() async {
    await _storage.delete(key: authStoreKey);
    await client.auth.signOut();
  }

  @override
  Future<bool> restoreSession() async {
    final session = await _storage.read(key: authStoreKey);
    if (session != null) {
      try {
        final response = await client.auth.recoverSession(session);
        if (response.user != null) {
          await saveSession();
          final token = await notification.generateToken();
          if (token != null) {
            await client.from("profiles").upsert({
              "id": response.user!.id,
              "fcm_token": token,
            });
          }
          return true;
        }
      } catch (e) {
        await clearSession();
      }
    }
    return false;
  }

  @override
  Future<bool> saveSession() async {
    final user = client.auth.currentUser;
    if (user == null) {
      return false;
    }
    final strSession = jsonEncode(client.auth.currentSession!.toJson());
    await _storage.write(key: authStoreKey, value: strSession);
    return true;
  }

  @override
  String getUserEmail() {
    return client.auth.currentUser?.email ?? "";
  }
}
