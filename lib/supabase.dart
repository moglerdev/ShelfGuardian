import 'package:supabase_flutter/supabase_flutter.dart';

final gotrueStorageKey = SharedPreferencesGotrueAsyncStorage();

class SupabaseCredentials {
  static const String supabaseUrl = 'https://cvphrepnshydslopzqat.supabase.co';
  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN2cGhyZXBuc2h5ZHNsb3B6cWF0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTk3NjQ4OTksImV4cCI6MjAzNTM0MDg5OX0.YlqQwhH28d4upTtYYx4eBpcbXxN4-gY9VVaLkNX1unk';
}

class SupabaseApi {
  static SupabaseClient client = SupabaseClient(
    SupabaseCredentials.supabaseUrl,
    SupabaseCredentials.supabaseAnonKey,
    authOptions: AuthClientOptions(
      autoRefreshToken: true,
      pkceAsyncStorage: gotrueStorageKey,
      authFlowType: AuthFlowType.pkce,
    ),
    storageOptions: const StorageClientOptions(),
  );
}
