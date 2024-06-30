import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:shelf_guardian/auth/bloc/auth_controller.dart';
import 'package:shelf_guardian/routes.dart';
import 'package:shelf_guardian/service/notification_service.dart';
import 'package:shelf_guardian/service/user_service.dart';
import 'package:shelf_guardian/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Moment.setGlobalLocalization(MomentLocalizations.de());

  await Supabase.initialize(
    url: SupabaseCredentials.supabaseUrl,
    anonKey: SupabaseCredentials.supabaseAnonKey,
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final notification = NotificationService.create();
  await notification.requestPermission();

  await FirebaseMessaging.instance.requestPermission(provisional: true);
  final service = UserService.create();
  await service.restoreSession();

  runApp(const ShelfGuardianApp());
}

class ShelfGuardianApp extends StatelessWidget {
  const ShelfGuardianApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthControllerCubit(),
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
