import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shelf_guardian/features/auth/bloc/auth_controller.dart';
import 'package:shelf_guardian/common/routes_service.dart';
import 'package:shelf_guardian/components/input_field.dart';
import 'package:shelf_guardian/components/text_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatedPasswordController =
      TextEditingController();

  Future<void> _signUp() async {
    final router = GoRouter.of(context);
    final sm = ScaffoldMessenger.of(context);
    final controller = context.read<AuthControllerCubit>();

    final password = _passwordController.text;
    final repeatedPassword = _repeatedPasswordController.text;

    if (password != repeatedPassword) {
      sm.showSnackBar(
        const SnackBar(content: Text('Passwords do not match!')),
      );
      return;
    }

    final isSuccess = await controller.signUp(_emailController.text, password);

    if (isSuccess) {
      sm.showSnackBar(
        const SnackBar(content: Text('Du wurdest erfolgreich registriert.')),
      );
      router.pushReplacement(NavigationServiceRoutes.signInRouteUri);
    } else {
      sm.showSnackBar(
        const SnackBar(content: Text("Something went wrong!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Registrieren'),
        ),
        body: AutofillGroup(
          child: ListView(
            children: [
              InputField(
                autofillHints: const [AutofillHints.email],
                controller: _emailController,
                name: 'Email',
              ),
              InputField(
                autofillHints: const [AutofillHints.newPassword],
                isPassword: true,
                controller: _passwordController,
                name: 'Passwort',
              ),
              InputField(
                autofillHints: const [AutofillHints.newPassword],
                isPassword: true,
                controller: _repeatedPasswordController,
                name: 'Passwort wiederholen',
              ),
              SGTextButton(
                onPressed: _signUp,
                buttonText: 'Registrieren',
              ),
            ],
          ),
        ));
  }
}
