import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shelf_guardian/auth/bloc/auth_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signIn() async {
    final router = GoRouter.of(context);
    final sm = ScaffoldMessenger.of(context);
    final controller = context.read<AuthControllerCubit>();
    try {
      final isSuccess = await controller.signIn(
          _emailController.text, _passwordController.text);

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
    } on AuthApiException {
        sm.showSnackBar(
          const SnackBar(content: Text("Please check your credentials!")),
        );
      } catch (e) {
        sm.showSnackBar(
          const SnackBar(content: Text(e)),
        );
      }
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
                hintText:
                    'Enter your email or username', // Suggests input format
                counterText: '', // Disable character counter for password field
              ),
            ),
            TextField(
              autofillHints: const [AutofillHints.password],
              autocorrect: false,
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password', // Suggests input format
                counterText: '', // Disable character counter for password field
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signIn,
              child: const Text('Sign In'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                context.push('/auth/sign-up');
              },
              child: const Text('Create Account'),
            ),
            TextButton(
              onPressed: () {
                context.push('/auth/forgot-password');
              },
              child: const Text('Forgot Password'),
            ),
          ],
        ),
      ),
    );
  }
}
