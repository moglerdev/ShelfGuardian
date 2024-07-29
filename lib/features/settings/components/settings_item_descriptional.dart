import 'package:flutter/material.dart';
import 'package:shelf_guardian/common/theme.dart';

/// A widget that displays a settings item with a name, description, and a value.
/// The item is styled with a custom theme and includes a container for the value.
class SettingsItemDescriptional extends StatelessWidget {
  final String name;
  final String description;
  final String value;

  /// Constructor for [SettingsItemDescriptional].
  ///
  /// Takes a [name] for the title, a [description] for additional details,
  /// and a [value] to be displayed in a styled container.
  const SettingsItemDescriptional({
    super.key,
    required this.name,
    required this.description,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Container(
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ShelfGuardianColors.button,
            ),
            child: Text(
              value,
              style: ShelfGuardianTextStyles.header1,
            ),
          ),
        ],
      ),
    );
  }
}
