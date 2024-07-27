import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shelf_guardian/common/theme.dart';
import 'package:shelf_guardian/components/icon_button.dart';
import 'package:shelf_guardian/features/filter/bloc/filter_controller.dart';
import 'package:shelf_guardian/features/filter/services/filter_dao.dart';
import 'package:shelf_guardian/features/filter/services/filter_options.dart';

class FilterDropdown extends StatelessWidget {
  const FilterDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
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
            "Sortierung",
            style: ShelfGuardianTextStyles.header1,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ShelfGuardianColors.button,
                      ),
                      child: DropdownMenu<FilterOptions>(
                        onSelected: (FilterOptions? value) {
                          context
                              .read<FilterControllerCubit>()
                              .updateFilterOption(
                                  value ?? FilterOptions.expired_at);
                        },
                        textStyle: ShelfGuardianTextStyles.body1,
                        inputDecorationTheme: const InputDecorationTheme(
                            border: InputBorder.none),
                        initialSelection: context
                            .read<FilterControllerCubit>()
                            .getSelectedFilter(),
                        controller: controller,
                        requestFocusOnTap: true,
                        dropdownMenuEntries: FilterOptions.values
                            .map<DropdownMenuEntry<FilterOptions>>(
                                (FilterOptions option) {
                          return DropdownMenuEntry<FilterOptions>(
                            label: option.label,
                            value: option,
                          );
                        }).toList(),
                      ))),
              SGIconButton(
                icon: context.watch<FilterControllerCubit>().isAscending()
                    ? FontAwesomeIcons.sortUp
                    : FontAwesomeIcons.sortDown,
                onPressed: () {
                  context.read<FilterControllerCubit>().toggleSortOrder();
                },
              ),
            ],
          )
        ]),
      );
    });
  }
}
