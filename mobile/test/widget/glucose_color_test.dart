import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glucocoach/presentation/theme/app_colors.dart';
import 'package:glucocoach/presentation/widgets/glucose_value_widget.dart';

void main() {
  group('GlucoseValue Widget', () {
    testWidgets('renders glucose value with correct color for normal range',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GlucoseValue(sgv: 120),
          ),
        ),
      );

      expect(find.text('120'), findsOneWidget);
      expect(find.text('In Range'), findsOneWidget);

      final textWidget = tester.widget<Text>(find.text('120'));
      expect(textWidget.style?.color, AppColors.glucoseNormal);
    });

    testWidgets('renders glucose value with red color for low', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GlucoseValue(sgv: 60),
          ),
        ),
      );

      expect(find.text('60'), findsOneWidget);
      expect(find.text('Low'), findsOneWidget);

      final textWidget = tester.widget<Text>(find.text('60'));
      expect(textWidget.style?.color, AppColors.glucoseLow);
    });

    testWidgets('renders glucose value with orange color for high',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GlucoseValue(sgv: 200),
          ),
        ),
      );

      expect(find.text('200'), findsOneWidget);
      expect(find.text('High'), findsOneWidget);

      final textWidget = tester.widget<Text>(find.text('200'));
      expect(textWidget.style?.color, AppColors.glucoseHigh);
    });

    testWidgets('renders trend arrow for rising glucose', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GlucoseValue(sgv: 120, direction: 'SingleUp'),
          ),
        ),
      );

      expect(find.text('↗'), findsOneWidget);
    });

    testWidgets('renders trend arrow for falling glucose', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GlucoseValue(sgv: 120, direction: 'SingleDown'),
          ),
        ),
      );

      expect(find.text('↘'), findsOneWidget);
    });

    testWidgets('does not show label when showLabel is false', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GlucoseValue(sgv: 120, showLabel: false),
          ),
        ),
      );

      expect(find.text('120'), findsOneWidget);
      expect(find.text('In Range'), findsNothing);
    });
  });
}
