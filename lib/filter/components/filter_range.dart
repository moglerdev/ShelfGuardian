import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/common/theme.dart';
import 'package:shelf_guardian/filter/bloc/filter_controller.dart';
import 'package:shelf_guardian/components/date_picker.dart';
import 'package:shelf_guardian/filter/services/filter_dao.dart';

class FilterRange extends StatelessWidget {
  const FilterRange({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterControllerCubit, FilterDAO>(
        builder: (context, state) {
      return Container(
        // height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ShelfGuardianColors.primary,
        ),
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        padding: const EdgeInsets.all(10),

        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Bereich",
            style: ShelfGuardianTextStyles.header1,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Von",
                style: ShelfGuardianTextStyles.body1,
              ),
              DatePicker(
                  setDate: (pickedDate) {
                    context
                        .read<FilterControllerCubit>()
                        .updateDateFrom(pickedDate);
                  },
                  date: context.read<FilterControllerCubit>().getDateFrom()),
              const Text(
                "Bis",
                style: ShelfGuardianTextStyles.body1,
              ),
              DatePicker(
                  setDate: (pickedDate) {
                    context
                        .read<FilterControllerCubit>()
                        .updateDateTo(pickedDate);
                  },
                  date: context.read<FilterControllerCubit>().getDateTo()),
            ],
          )
        ]),
      );
    });
  }
}
