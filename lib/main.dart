import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:form_aula/screens/companies.dart';
import 'package:form_aula/screens/myApplications.dart';

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
  int _index = 0;

  final List<List<dynamic>> _tabs = [
    ["Companies", CompaniesList()],
    ["Job Applications", MyJobApplications()],
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(title: Text(_tabs.elementAt(_index).elementAt(0))),
      body: _tabs.elementAt(_index).elementAt(1),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.business),
              label: _tabs.elementAt(0).elementAt(0)),
          BottomNavigationBarItem(
              icon: const Icon(Icons.shopping_cart),
              label: _tabs.elementAt(1).elementAt(0)),
        ],
      ),
    ));
  }

  void onTabTapped(int index) {
    setState(() {
      _index = index;
    });
  }
}
