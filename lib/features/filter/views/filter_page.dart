import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/features/filter/views/filter_view.dart';
import 'package:shelf_guardian/features/filter/bloc/filter_controller.dart';
import 'package:shelf_guardian/features/product/bloc/product_controller.dart';
import 'package:shelf_guardian/features/filter/components/filter_action_button.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FilterControllerCubit>(
          create: (context) => FilterControllerCubit(),
        ),
        BlocProvider<ProductControllerCubit>(
          create: (context) => ProductControllerCubit(),
        ),
      ],
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Filter'),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: const FilterActionButton(),
          body: const FilterPageView()),
    );
  }
}
