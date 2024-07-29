import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shelf_guardian/common/theme.dart';
import 'package:shelf_guardian/components/icon_button.dart';

void main() {
  testWidgets('SGIconButton has correct style when enabled',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SGIconButton(
          icon: FontAwesomeIcons.a,
          onPressed: () {},
        ),
      ),
    ));

    final iconButton = tester.widget<IconButton>(find.byType(IconButton));
    final style = ShelfGuardianButtonStyles.buttonEnabled.copyWith(
      fixedSize: WidgetStateProperty.all(const Size(55, 55)),
    );
    expect(
        iconButton.style?.fixedSize?.resolve({}), style.fixedSize?.resolve({}));
  });

  testWidgets('SGIconButton has correct style when disabled',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SGIconButton(
          icon: FontAwesomeIcons.home,
          onPressed: () {},
          disabled: true,
        ),
      ),
    ));

    final iconButton = tester.widget<IconButton>(find.byType(IconButton));
    final style = ShelfGuardianButtonStyles.buttonDisabled.copyWith(
      fixedSize: MaterialStateProperty.all(Size(55, 55)),
    );
    expect(
        iconButton.style?.fixedSize?.resolve({}), style.fixedSize?.resolve({}));
  });

  testWidgets('SGIconButton onPressed callback is triggered when enabled',
      (WidgetTester tester) async {
    var wasPressed = false;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SGIconButton(
          icon: FontAwesomeIcons.home,
          onPressed: () {
            wasPressed = true;
          },
        ),
      ),
    ));

    await tester.tap(find.byType(IconButton));
    await tester.pump(); // Allow any animations to complete

    expect(wasPressed, isTrue);
  });

  testWidgets('SGIconButton onPressed callback is not triggered when disabled',
      (WidgetTester tester) async {
    var wasPressed = false;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SGIconButton(
          icon: FontAwesomeIcons.home,
          onPressed: () {
            wasPressed = true;
          },
          disabled: true,
        ),
      ),
    ));

    await tester.tap(find.byType(IconButton));
    await tester.pump(); // Allow any animations to complete

    expect(wasPressed, isFalse);
  });
}
