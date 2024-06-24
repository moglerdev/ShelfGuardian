import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/common/theme.dart';
import 'package:shelf_guardian/filter/bloc/filter_controller.dart';
import 'package:shelf_guardian/product/bloc/product_state.dart';

class FilterRange extends StatelessWidget {
  const FilterRange({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController startDateController = TextEditingController();
    final TextEditingController endDateController = TextEditingController();
    return BlocBuilder<FilterControllerCubit, ProductListState>(
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
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 10, left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ShelfGuardianColors.button,
                    ),
                  child: TextField(
                    style: ShelfGuardianTextStyles.body1,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10, right: 10),
                      border: InputBorder.none,
                    ),
                    controller: startDateController,
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2024),
                        lastDate: DateTime(2124),
                      );

                      if(pickedDate != null) {
                        startDateController.text = DateFormat('dd.MM.yyyy').format(pickedDate);
                      }
                    },
                  ))),
              const Text(
                "Bis",
                style: ShelfGuardianTextStyles.body1,
              ),
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ShelfGuardianColors.button,
                    ),
                  child: TextField(
                    style: ShelfGuardianTextStyles.body1,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10, right: 10),
                      border: InputBorder.none,
                    ),
                    controller: endDateController,
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );

                      if(pickedDate != null) {
                        endDateController.text = DateFormat('dd.MM.yyyy').format(pickedDate);
                      }
                    },
                  ))),
            ],
          )
        ]),
      );
    });
  }
}
