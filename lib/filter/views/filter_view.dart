import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shelf_guardian/components/input_field.dart';
import 'package:shelf_guardian/filter/components/filter_dropdown.dart';
import 'package:shelf_guardian/filter/components/filter_range.dart';
import 'package:shelf_guardian/product/bloc/product_state.dart';
import 'package:shelf_guardian/filter/bloc/filter_controller.dart';

class FilterPageView extends StatelessWidget {
  const FilterPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterControllerCubit, ProductListState>(
        builder: (context, state) {
          return const Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          FilterDropdown(), FilterRange()
          ]);
        });
  }
}
