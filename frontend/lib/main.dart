import 'package:flutter/material.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/bloc/product_bloc.dart';
import 'package:shelf_guardian/pages/home_page.dart';

void main() {
  Moment.setGlobalLocalization(MomentLocalizations.de());
  runApp(const ShelfGuardianApp());
}

class ShelfGuardianApp extends StatelessWidget {
  const ShelfGuardianApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductBloc()..add(LoadProductsEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Shelf Guardian',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
