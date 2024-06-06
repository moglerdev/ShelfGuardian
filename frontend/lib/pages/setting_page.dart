import 'package:flutter/material.dart';
import 'package:shelf_guardian/routes.dart';

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
                onPressed: () {
                  AppRoutes.navigateToHome(context);
                },
                child: const Text("Back to Home Page"))
          ],
        ));
  }
}
