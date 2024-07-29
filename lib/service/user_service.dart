import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shelf_guardian/service/notification_service.dart';
import 'package:shelf_guardian/supabase.dart';

/// This file contains the implementation of the [UserService] abstract class and the [SupabaseUserService] class.
/// The [UserService] defines the contract for user-related operations such as sign-in, sign-up, password reset, and session management.
/// The [SupabaseUserService] class implements the [UserService] and provides the actual implementation using the Supabase API.
/// It also uses the [FlutterSecureStorage] for securely storing the user session and the [NotificationService] for handling notifications.
///
/// The [UserService] provides the following methods:
/// - `signIn`: Signs in the user with the provided email and password.
/// - `signUp`: Signs up the user with the provided email and password.
/// - `resetPassword`: Sends a password reset email to the provided email address.
/// - `signOut`: Signs out the current user.
/// - `getUserEmail`: Returns the email of the current user.
/// - `isSignedIn`: Checks if a user is currently signed in.
/// - `clearSession`: Clears the user session.
/// - `restoreSession`: Restores the user session from the stored session data.
/// - `saveSession`: Saves the current user session.
///
/// The [SupabaseUserService] class implements the [UserService] methods using the Supabase API and provides additional functionality for session management and notification handling.
/// It also uses the [FlutterSecureStorage] for securely storing the user session and the [NotificationService] for handling notifications.
///
/// Example usage:
/// ```dart
/// final userService = UserService.create();
/// final signedIn = await userService.signIn('user@example.com', 'password');
/// if (signedIn) {
///   final userEmail = userService.getUserEmail();
///   print('Signed in as $userEmail');
/// } else {
///   print('Sign-in failed');
/// }
/// ```
abstract class UserService {
  /// Signs in the user with the provided email and password.
  /// Returns `true` if the sign-in is successful, `false` otherwise.
  Future<bool> signIn(String email, String password);

  /// Signs up the user with the provided email and password.
  /// Returns `true` if the sign-up is successful, `false` otherwise.
  Future<bool> signUp(String email, String password);

  /// Sends a password reset email to the provided email address.
  /// Returns `true` if the password reset email is sent successfully, `false` otherwise.
  Future<bool> resetPassword(String email);

  /// Signs out the current user.
  /// Returns `true` if the sign-out is successful, `false` otherwise.
  Future<bool> signOut();

  /// Returns the email of the current user.
  String getUserEmail();

  /// Checks if a user is currently signed in.
  /// Returns `true` if a user is signed in, `false` otherwise.
  bool isSignedIn();

  /// Clears the user session.
  Future<void> clearSession();

  /// Restores the user session from the stored session data.
  /// Returns `true` if the session is successfully restored, `false` otherwise.
  Future<bool> restoreSession();

  /// Saves the current user session.
  /// Returns `true` if the session is successfully saved, `false` otherwise.
  Future<bool> saveSession();

  /// Creates an instance of the [UserService] using the Supabase implementation.
  static UserService create() {
    return SupabaseUserService();
  }
}

const _storage = FlutterSecureStorage();

class SupabaseUserService implements UserService {
  final client = Api.client;
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
    return client.auth.currentUser?.email ??
        "Du wirst ja wohl wissen, wie du heißt!";
  }
}
