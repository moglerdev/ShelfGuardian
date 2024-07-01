import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:shelf_guardian/auth/bloc/auth_controller.dart';
import 'package:shelf_guardian/routes.dart';
import 'package:shelf_guardian/service/notification_service.dart';
import 'package:shelf_guardian/service/user_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shelf_guardian/supabase.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Moment.setGlobalLocalization(MomentLocalizations.de());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Api.init();

  final notification = NotificationService.create();
  await notification.requestPermission();

  final service = UserService.create();
  await service.restoreSession();

  runApp(const Application());
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<StatefulWidget> createState() => _Application();
}

class _Application extends State<Application> {
  // In this example, suppose that all messages contain a data field with the key 'type'.
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    context.push('/chat');
  }

  @override
  void initState() {
    super.initState();

    // Run code required to handle interacted messages in an async function
    // as initState() must not be async
    setupInteractedMessage();
  }

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
