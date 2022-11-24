import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_aula/screens/companies.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'companies_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Mocking tests', () {
    test('returns an Album if the http call completes successfully', () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse(
              "https://63541afbe64783fa827f6418.mockapi.io/pjam/companies/")))
          .thenAnswer((_) async =>
              http.Response('[{"id": "1", "name": "teste"}]', 200));

      expect(await setCompanies(client), isA<List>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse(
              "https://63541afbe64783fa827f6418.mockapi.io/pjam/companies/")))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(setCompanies(client), throwsException);
    });
  });
  testWidgets('Validate the number of companies', (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(home: CompaniesList()));
    /*final Finder companiesFinder = find.byType(ListView);
    expect(companiesFinder, findsWidgets);
    final Finder companiesFinder = find.text("Companies");
    expect(companiesFinder, findsWidgets);*/

    //TODO: Check why this is not working
  });
}
