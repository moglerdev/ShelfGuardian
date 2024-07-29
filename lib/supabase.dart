import 'package:supabase_flutter/supabase_flutter.dart';

// A storage key for the Gotrue authentication provider
final gotrueStorageKey = SharedPreferencesGotrueAsyncStorage();

// Class that holds the Supabase credentials
class SupabaseCredentials {
  // The URL of the Supabase server
  static const String supabaseUrl = 'https://cvphrepnshydslopzqat.supabase.co';

  // The anonymous key used for authentication
  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN2cGhyZXBuc2h5ZHNsb3B6cWF0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTk3NjQ4OTksImV4cCI6MjAzNTM0MDg5OX0.YlqQwhH28d4upTtYYx4eBpcbXxN4-gY9VVaLkNX1unk';
}

// Class that provides methods for interacting with the Supabase API
class Api {
  // Initializes the Supabase client
  static Future<void> init() async {
    await Supabase.initialize(
      url: SupabaseCredentials.supabaseUrl,
      anonKey: SupabaseCredentials.supabaseAnonKey,
      realtimeClientOptions: const RealtimeClientOptions(
        eventsPerSecond: 2,
      ),
      authOptions: FlutterAuthClientOptions(
        autoRefreshToken: true,
        pkceAsyncStorage: gotrueStorageKey,
        authFlowType: AuthFlowType.pkce,
      ),
      storageOptions: const StorageClientOptions(),
    );
  }

  // The Supabase client instance
  static SupabaseClient client = Supabase.instance.client;
}
