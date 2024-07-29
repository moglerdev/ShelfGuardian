import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shelf_guardian/features/auth/bloc/auth_controller.dart';
import 'package:shelf_guardian/common/routes_service.dart';
import 'package:shelf_guardian/components/input_field.dart';
import 'package:shelf_guardian/components/text_button.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  Future<void> _resetPassword() async {
    final router = GoRouter.of(context);
    final sm = ScaffoldMessenger.of(context);
    final controller = context.read<AuthControllerCubit>();

    final isSuccess = await controller.resetPassword(_emailController.text);

    if (isSuccess) {
      sm.showSnackBar(
        const SnackBar(
            content:
                Text('Email zum Zurücksetzen des Passworts wurde gesendet!')),
      );
      router.pushReplacement(NavigationServiceRoutes.signInRouteUri);
    } else {
      sm.showSnackBar(
        const SnackBar(content: Text("Etwas ist schiefgelaufen!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Passwort vergessen'),
        ),
        body: AutofillGroup(
          child: ListView(
            children: [
              InputField(
                autofillHints: const [AutofillHints.email],
                controller: _emailController,
                name: 'Email',
              ),
              SGTextButton(
                onPressed: _resetPassword,
                buttonText: 'Passwort zurücksetzen',
              ),
            ],
          ),
        ));
  }
}
