import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelf_guardian/common/theme.dart';
import 'package:shelf_guardian/components/text_button.dart';

void main() {
  testWidgets('SGTextButton displays the correct text',
      (WidgetTester tester) async {
    const buttonText = 'Test Button';

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SGTextButton(
          buttonText: buttonText,
          onPressed: () {},
        ),
      ),
    ));

    expect(find.text(buttonText), findsOneWidget);
  });

  testWidgets('SGTextButton has correct style', (WidgetTester tester) async {
    const buttonText = 'Test Button';

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SGTextButton(
          buttonText: buttonText,
          onPressed: () {},
        ),
      ),
    ));

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(
        button.style?.backgroundColor?.resolve({}), ShelfGuardianColors.button);
    expect(
        button.style?.shape?.resolve({}),
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ));
  });

  testWidgets('SGTextButton onPressed callback is triggered',
      (WidgetTester tester) async {
    var wasPressed = false;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SGTextButton(
          buttonText: 'Test Button',
          onPressed: () {
            wasPressed = true;
          },
        ),
      ),
    ));

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(wasPressed, isTrue);
  });
}
