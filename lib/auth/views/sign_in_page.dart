import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shelf_guardian/auth/bloc/auth_controller.dart';
import 'package:shelf_guardian/auth/bloc/auth_state.dart';
import 'package:shelf_guardian/common/routes_service.dart';
import 'package:shelf_guardian/components/input_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:shelf_guardian/components/text_button.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
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
        router.go('/');
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
        const SnackBar(content: Text("Something went wrong!")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (context.read<AuthControllerCubit>().state is AuthenticatedState) {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: ListView(
        children: [
          InputField(
            autofillHints: const [AutofillHints.email],
            controller: _emailController,
            name: 'Email',
          ),
          InputField(
            autofillHints: const [AutofillHints.password],
            isPassword: true,
            controller: _passwordController,
            name: 'Passwort',
            onSubmitted: _signIn,
          ),
          SGTextButton(
            onPressed: _signIn,
            buttonText: 'Anmelden',
          ),
          SGTextButton(
            onPressed: () {
              context.push(NavigationServiceRoutes.signUpRouteUri);
            },
            buttonText: 'Registrieren',
          ),
          SGTextButton(
            onPressed: () {
              context.push(NavigationServiceRoutes.forgotPasswordRouteUri);
            },
            buttonText: 'Passwort vergessen',
          ),
        ],
      ),
    );
  }
}

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Anmelden'),
        ),
        body: BlocBuilder<AuthControllerCubit, AuthenticationState>(
          builder: (context, state) {
            if (state is UnauthenticatedState) {
              return const SignInView();
            } else if (state is AuthenticatingState) {
              return const Center(child: CircularProgressIndicator());
            }
            return const Center(
              child: Text("data not found!"),
            );
          },
        ));
  }
}
