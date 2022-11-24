import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_aula/screens/login.dart';

void main() {
  group('Test widgets', () {
    // Define a test. The TestWidgets function also provides a WidgetTester
    // to work with. The WidgetTester allows building and interacting
    // with widgets in the test environment.
    testWidgets('Login widget has name and password', (tester) async {
      // Create the widget by telling the tester to build it.
      await tester.pumpWidget(const MaterialApp(
        home: Login(),
      ));

      // Create the Finders.
      final emailFinder = find.text('Email');
      final passwordFinder = find.text('Password');

      // Use the `findsOneWidget` matcher provided by flutter_test to
      // verify that the Text widgets appear exactly once in the widget tree.
      expect(emailFinder, findsOneWidget);
      expect(passwordFinder, findsOneWidget);
    });

    testWidgets('Login widget has submit button', (tester) async {
      // Create the widget by telling the tester to build it.
      await tester.pumpWidget(const MaterialApp(
        home: Login(),
      ));

      // Create the Finders.
      final loginButtonFinder = find.text('Login');

      // Use the `findsOneWidget` matcher provided by flutter_test to
      // verify that the Text widgets appear exactly once in the widget tree.
      expect(loginButtonFinder, findsOneWidget);
    });
  });
}
