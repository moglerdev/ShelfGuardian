import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shelf_guardian/auth/bloc/auth_controller.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Shelf Guardian'),
        ),
        body: Column(
          children: [
            TextButton(
                onPressed: () async {
                  final route = GoRouter.of(context);
                  await context.read<AuthControllerCubit>().signOut();
                  route.go("/");
                },
                child: const Text("Sign Out")),
            TextButton(
                onPressed: () {
                  context.go("/");
                },
                child: const Text("Back to Home Page"))
          ],
        ));
  }
}