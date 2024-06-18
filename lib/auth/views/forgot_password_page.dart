import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shelf_guardian/auth/bloc/auth_controller.dart';

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
        const SnackBar(content: Text('Signed in successfully!')),
      );
      router.pushReplacement('/sign-in');
    } else {
      sm.showSnackBar(
        const SnackBar(content: Text("Something went wrong!")),
      );
      // Navigate to your home page or another page
      // Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign In'),
        ),
        body: AutofillGroup(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
            children: [
              TextField(
                autofillHints: const [AutofillHints.email],
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _resetPassword,
                child: const Text('Send reset password email'),
              ),
            ],
          ),
        ));
  }
}
