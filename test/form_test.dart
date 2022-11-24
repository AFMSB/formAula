import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_aula/screens/form.dart';

void main() {
  group('Test form elements', () {
    // Define a test. The TestWidgets function also provides a WidgetTester
    // to work with. The WidgetTester allows building and interacting
    // with widgets in the test environment.
    testWidgets('Form has a title', (tester) async {
      // Create the widget by telling the tester to build it.
      await tester.pumpWidget(const MaterialApp(
        home: MyForm(title: "Teste"),
      ));

      // Create the Finders.
      final titleFinder = find.text('Teste');

      // Use the `findsOneWidget` matcher provided by flutter_test to
      // verify that the Text widgets appear exactly once in the widget tree.
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('Form has elements', (tester) async {
      // Create the widget by telling the tester to build it.
      await tester.pumpWidget(const MaterialApp(
        home: MyForm(title: "Teste"),
      ));

      // Create the Finders.
      final nameFinder = find.text('Nome');
      final resumeFinder = find.text('Resumo pessoal e profissional');
      final birthdateFinder = find.text('Data de Nascimento');
      final salaryFinder = find.text('Expectativa salarial');
      final emailFinder = find.text('E-mail');
      final linkedinFinder = find.text('LinkedIn');

      // Use the `findsOneWidget` matcher provided by flutter_test to
      // verify that the Text widgets appear exactly once in the widget tree.
      expect(nameFinder, findsOneWidget);
      expect(resumeFinder, findsOneWidget);
      expect(birthdateFinder, findsOneWidget);
      expect(salaryFinder, findsOneWidget);
      expect(emailFinder, findsOneWidget);
      expect(linkedinFinder, findsOneWidget);
    });
  });
}
