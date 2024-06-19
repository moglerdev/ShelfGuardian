import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shelf_guardian/auth/bloc/auth_controller.dart';

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
        const SnackBar(content: Text('Signed in successfully!')),
      );
      router.pushReplacement('/');
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
              TextField(
                autofillHints: const [AutofillHints.newPassword],
                autocorrect: false,
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Your Password',
                ),
              ),
              TextField(
                autofillHints: const [AutofillHints.newPassword],
                autocorrect: false,
                controller: _repeatedPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Repeat your Password',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signUp,
                child: const Text('Create Account'),
              ),
            ],
          ),
        ));
  }
}
