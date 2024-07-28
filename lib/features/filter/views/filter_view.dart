import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/features/filter/components/filter_dropdown.dart';
import 'package:shelf_guardian/features/filter/components/filter_range.dart';
import 'package:shelf_guardian/features/filter/services/filter_dao.dart';
import 'package:shelf_guardian/features/filter/bloc/filter_controller.dart';

class FilterPageView extends StatelessWidget {
  const FilterPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterControllerCubit, FilterDAO>(
        builder: (context, state) {
      return ListView(children: const [
        FilterDropdown(),
        FilterRange(),
        SizedBox(height: 100),
      ]);
    });
  }
}
