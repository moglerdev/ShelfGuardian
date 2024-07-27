import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelf_guardian/components/input_field.dart';

void main() {
  testWidgets('InputField is disabled when enabled is false',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: InputField(
          name: 'Test Field',
          enabled: false,
        ),
      ),
    ));

    final textField = tester.widget<TextField>(find.byType(TextField));
    expect(textField.enabled, isFalse);
  });

  testWidgets('InputField is a password field when isPassword is true',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: InputField(
          name: 'Password Field',
          isPassword: true,
        ),
      ),
    ));

    final textField = tester.widget<TextField>(find.byType(TextField));
    expect(textField.obscureText, isTrue);
  });

  testWidgets('InputField triggers onSubmitted callback',
      (WidgetTester tester) async {
    var wasSubmitted = false;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: InputField(
          name: 'Test Field',
          onSubmitted: () {
            wasSubmitted = true;
          },
        ),
      ),
    ));

    await tester.enterText(find.byType(TextField), 'New Value');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    expect(wasSubmitted, isTrue);
  });
}
