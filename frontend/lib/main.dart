import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:shelf_guardian/controller/product_controller.dart';
import 'package:shelf_guardian/routes.dart';

void main() {
  Moment.setGlobalLocalization(MomentLocalizations.de());
  runApp(const ShelfGuardianApp());
}

class ShelfGuardianApp extends StatelessWidget {
  const ShelfGuardianApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductController(),
      child: MaterialApp.router(
        title: 'Shelf Guardian',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerDelegate: routes.routerDelegate,
        routeInformationParser: routes.routeInformationParser,
      ),
    );
  }
}
