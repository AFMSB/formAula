import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:form_aula/screens/result_page.dart';

import 'form.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List<dynamic> candidatura = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Candidatura Espontânea',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Navigator(
        pages: [
          MaterialPage(
              key: const ValueKey('Form'),
              child: MyForm(
                  title: 'Candidatura Espontânea', callback: (value) {
                    setState(() {
                      candidatura = List<dynamic>.from(value);
                    });
              },
              )
          ),
          if(candidatura.isNotEmpty)
            MaterialPage(
              key: const ValueKey("Resultados"),
              child: ResultPage(candidatura: candidatura)
            )
        ],
        onPopPage: (route, result){
          if(!route.didPop(result)){
            return false;
          }
          return true;
        },
      ),
    );
  }
}


