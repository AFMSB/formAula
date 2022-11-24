import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_aula/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login test', () {
    testWidgets('Simulate Login', (widgetTester) async {
      app.main();
      await widgetTester.pumpAndSettle();

      final Finder emailFinder = find.text('Email');
      final Finder passwordFinder = find.text('Password');

      expect(emailFinder, findsOneWidget);
      expect(passwordFinder, findsOneWidget);

      final Finder buttonFinder = find.text('Login');
      expect(buttonFinder, findsOneWidget);

      await widgetTester.enterText(find.byType(TextField).first, "admin");
      await widgetTester.enterText(find.byType(TextField).at(1), "12345");

      await widgetTester.tap(buttonFinder);

      await widgetTester.pumpAndSettle();

      //verificar se mudou de screen
      final Finder companiesFinder = find.text("Companies");
      expect(companiesFinder, findsWidgets);
    });
  });
}
