import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/product/components/product_action_button.dart';
import 'package:shelf_guardian/product/bloc/product_controller.dart';
import 'package:shelf_guardian/product/views/product_view.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        var ctrl = ProductControllerCubit();
        ctrl.initProducts();
        return ctrl;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Shelf Guardian'),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: const ProductActionButton(),
          body: const ProductPageView()),
    );
  }
}
