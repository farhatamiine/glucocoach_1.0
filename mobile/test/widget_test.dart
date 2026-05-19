import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glucocoach/main.dart';

void main() {
  testWidgets('App renders', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: GlucoCoachApp()),
    );
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
