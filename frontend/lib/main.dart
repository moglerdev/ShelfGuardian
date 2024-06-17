import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:shelf_guardian/controller/settings_controller.dart';
import 'package:shelf_guardian/controller/user_controller.dart';
import 'package:shelf_guardian/routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Moment.setGlobalLocalization(MomentLocalizations.de());

  await Supabase.initialize(
    url: 'https://kong.mogler.dev/',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.ewogICJyb2xlIjogImFub24iLAogICJpc3MiOiAic3VwYWJhc2UiLAogICJpYXQiOiAxNzE4NTc1MjAwLAogICJleHAiOiAxODc2MzQxNjAwCn0.eTDeiCu4cGlRez4RXd9UUZZu-6OQ22i88EEAnI7PsCA',
  );
  runApp(const ShelfGuardianApp());
}

class ShelfGuardianApp extends StatelessWidget {
  const ShelfGuardianApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SettingsController()),
        BlocProvider(create: (context) => UserController()),
      ],
      child: MaterialApp.router(
        title: 'Shelf Guardian',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: routes,
      ),
    );
  }
}
