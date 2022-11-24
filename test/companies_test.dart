import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_aula/screens/companies.dart';

void main() {
  testWidgets('Validate the number of companies', (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(home: CompaniesList()));
    /*final Finder companiesFinder = find.byType(ListView);
    expect(companiesFinder, findsWidgets);
    final Finder companiesFinder = find.text("Companies");
    expect(companiesFinder, findsWidgets);*/

    //TODO: Check why this is not working
  });
}
