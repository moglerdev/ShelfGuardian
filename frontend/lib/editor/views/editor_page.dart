import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/product/components/product_action_button.dart';
import 'package:shelf_guardian/product/bloc/product_controller.dart';

class EditorPage extends StatelessWidget {
  final String code;

  const EditorPage({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductControllerCubit(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Editor'),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: const ProductActionButton(),
          body: Text("Barcode: $code")),
    );
  }
}
