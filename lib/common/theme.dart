import 'package:flutter/material.dart';

/// A class that defines the colors used in the ShelfGuardian app.
class ShelfGuardianColors {
  static const Color primary = Color(0xFF5603AD);
  static const Color secondary = Color(0xFFAD0392);
  static const Color button = Color(0xFF8367C7);
  static const Color disabled = Color(0xFF808080);
  static const Color icon = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFFFFFFF);
}

/// A class that defines the text styles used in the ShelfGuardian app.
class ShelfGuardianTextStyles {
  static const TextStyle header1 = TextStyle(
      color: Color(0xFFFFFFFF), fontSize: 20, fontWeight: FontWeight.bold);
  static const TextStyle body1 = TextStyle(
      color: Color(0xFFFFFFFF), fontSize: 16, fontWeight: FontWeight.normal);
}

/// A class that defines the button styles used in the ShelfGuardian app.
class ShelfGuardianButtonStyles {
  static ButtonStyle buttonEnabled = ButtonStyle(
    shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
    backgroundColor: const WidgetStatePropertyAll(ShelfGuardianColors.button),
    iconColor: const WidgetStatePropertyAll(ShelfGuardianColors.icon),
  );
  static ButtonStyle buttonDisabled = ButtonStyle(
    shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
    backgroundColor: const WidgetStatePropertyAll(ShelfGuardianColors.disabled),
    iconColor: const WidgetStatePropertyAll(ShelfGuardianColors.icon),
  );
}
