import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCredentials {
  static const String supabaseUrl = 'https://kong.mogler.dev/';
  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.ewogICJyb2xlIjogImFub24iLAogICJpc3MiOiAiaHR0cHM6Ly9rb25nLm1vZ2xlci5kZXYiLAogICJpYXQiOiAxNzE4NTc1MjAwLAogICJleHAiOiAxODc2MzQxNjAwCn0.gpqnw1nl7iXFrpVOf4rh6XgmFkgvk-85zEkwWaFg5M0';
}

class SupabaseClientInstance {
  static final SupabaseClient supabaseClient = SupabaseClient(
    SupabaseCredentials.supabaseUrl,
    SupabaseCredentials.supabaseAnonKey,
  );
}
