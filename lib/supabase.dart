import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const storage = FlutterSecureStorage();

class SupabaseCredentials {
  static const String supabaseUrl = 'https://kong.mogler.dev/';
  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.ewogICJyb2xlIjogImFub24iLAogICJpc3MiOiAiaHR0cHM6Ly9rb25nLm1vZ2xlci5kZXYiLAogICJpYXQiOiAxNzE4NTc1MjAwLAogICJleHAiOiAxODc2MzQxNjAwCn0.gpqnw1nl7iXFrpVOf4rh6XgmFkgvk-85zEkwWaFg5M0';
}

class SBClient {
  static final SupabaseClient supabaseClient = SupabaseClient(
    SupabaseCredentials.supabaseUrl,
    SupabaseCredentials.supabaseAnonKey,
    authOptions: const AuthClientOptions(
      autoRefreshToken: true,
    ),
    storageOptions: const StorageClientOptions(),
  );
}

Future<bool> loadSession() async {
  final client = SBClient.supabaseClient;
  final user = client.auth.currentUser;
  if (user != null) {
    await storage.write(
        key: 'kong.mogler.dev:session',
        value: client.auth.currentSession!.toJson().toString());
    return true;
  }
  final session = await storage.read(key: "kong.mogler.dev:session");
  if (session != null) {
    final response = await client.auth.recoverSession(session);
    if (response.user != null) {
      return true;
    }
  }
  return false;
}

Future<bool> saveSession() async {
  final client = SBClient.supabaseClient;
  final user = client.auth.currentUser;
  if (user == null) {
    return false;
  }
  final strSession = jsonEncode(client.auth.currentSession!.toJson());
  await storage.write(key: 'kong.mogler.dev:session', value: strSession);
  return true;
}

Future<void> clearSession() async {
  await storage.delete(key: 'kong.mogler.dev:session');
}
