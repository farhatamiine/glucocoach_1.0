import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glucocoach/presentation/screens/auth/login_screen.dart';

void main() {
  group('LoginScreen', () {
    testWidgets('shows email and password fields', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('validates empty email', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      await tester.tap(find.widgetWithText(ElevatedButton, 'Sign In'));
      await tester.pump();

      expect(find.text('Please enter your email'), findsOneWidget);
    });

    testWidgets('validates invalid email', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      await tester.enterText(find.byType(TextFormField).first, 'invalid');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Sign In'));
      await tester.pump();

      expect(find.text('Please enter a valid email'), findsOneWidget);
    });

    testWidgets('validates empty password', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      await tester.enterText(find.byType(TextFormField).first, 'test@test.com');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Sign In'));
      await tester.pump();

      expect(find.text('Please enter your password'), findsOneWidget);
    });

    testWidgets('toggles password visibility', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      expect(find.byIcon(Icons.visibility_off), findsOneWidget);

      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();

      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });
  });
}
