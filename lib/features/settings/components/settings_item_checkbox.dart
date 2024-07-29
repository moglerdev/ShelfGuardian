import 'package:flutter/material.dart';
import 'package:shelf_guardian/common/theme.dart';
import 'package:shelf_guardian/components/checkbox.dart';

/// A custom checkbox item used in settings, displaying a name and description.
/// Allows toggling of selection state via a checkbox or a long press on the entire item.
class SettingsItemCheckbox extends StatelessWidget {
  final String name;
  final String description;
  final void Function(bool) onSelectChanged;
  final bool isSelected;

  /// Constructor for [SettingsItemCheckbox].
  ///
  /// Takes a [name] for the title, a [description], a [onSelectChanged] callback
  /// for handling selection changes, and an [isSelected] boolean indicating the current selection state.
  const SettingsItemCheckbox({
    super.key,
    required this.name,
    required this.description,
    required this.onSelectChanged,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        onSelectChanged(!isSelected);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ShelfGuardianColors.primary,
        ),
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: ShelfGuardianTextStyles.header1,
                  ),
                  Text(
                    description,
                    style: ShelfGuardianTextStyles.body1,
                  ),
                ],
              ),
            ),
            SGCheckBox(
              onSelectChanged: (selected) {
                onSelectChanged(selected);
              },
              isSelected: isSelected,
            ),
          ],
        ),
      ),
    );
  }
}
