import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shelf_guardian/common/theme.dart';
import 'package:shelf_guardian/components/checkbox.dart';

void main() {
  group('SGCheckBox', () {
    late bool isSelected;
    late bool onChangedValue;

    void onSelectChanged(bool value) {
      onChangedValue = value;
    }

    setUp(() {
      isSelected = false;
      onChangedValue = false;
    });

    testWidgets('renders correctly when not selected',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: SGCheckBox(
              onSelectChanged: onSelectChanged,
              isSelected: isSelected,
            ),
          ),
        ),
      );

      final containerFinder = find.byType(Container);
      final elevatedButtonFinder = find.byType(ElevatedButton);
      final faIconFinder = find.byType(FaIcon);

      expect(containerFinder, findsOneWidget);
      expect(elevatedButtonFinder, findsOneWidget);
      expect(faIconFinder, findsOneWidget);

      final container = tester.widget<Container>(containerFinder);
      final elevatedButton =
          tester.widget<ElevatedButton>(elevatedButtonFinder);
      final faIcon = tester.widget<FaIcon>(faIconFinder);

      expect(container.margin, const EdgeInsets.only(left: 10));

      final padding =
          elevatedButton.style?.padding?.resolve({WidgetState.pressed});
      final minimumSize =
          elevatedButton.style?.minimumSize?.resolve({WidgetState.pressed});

      expect(padding, const EdgeInsets.all(10));
      expect(minimumSize, const Size(40, 40));

      expect(elevatedButton.onPressed, isNotNull);
      expect(faIcon.icon, FontAwesomeIcons.check);
      expect(faIcon.color, Colors.transparent);
      expect(faIcon.size, 40);
    });
    testWidgets('renders correctly when selected', (WidgetTester tester) async {
      isSelected = true;

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: SGCheckBox(
              onSelectChanged: onSelectChanged,
              isSelected: isSelected,
            ),
          ),
        ),
      );

      final faIconFinder = find.byType(FaIcon);
      final faIcon = tester.widget<FaIcon>(faIconFinder);

      expect(faIcon.color, ShelfGuardianColors.icon);
    });

    testWidgets('calls onSelectChanged callback when tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: SGCheckBox(
              onSelectChanged: onSelectChanged,
              isSelected: isSelected,
            ),
          ),
        ),
      );

      final elevatedButtonFinder = find.byType(ElevatedButton);

      await tester.tap(elevatedButtonFinder);
      await tester.pump();

      expect(onChangedValue, true);
    });
  });
}
