import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:form_aula/models/jobApplication.dart';
import 'package:form_aula/screens/companies.dart';
import 'package:form_aula/screens/login.dart';
import 'package:form_aula/screens/myJobApplications.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import 'models/myApplications.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(ChangeNotifierProvider(
      create: (context) => MyJobApplicationsModel(),
      child: MaterialApp(
        home: Login(),
      )));
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
    ["My Job Applications", const MyJobApplications()],
  ];

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    queryFromDatabase();
  }

  void queryFromDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();

    final DataBase = await openDatabase(
        path.join(await getDatabasesPath(), "jobApplications.db"),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE Jobs (id INTEGER PRIMARY KEY, company TEXT, name TEXT, resume TEXT, birthDate TEXT, salary REAL, email TEXT, linkedIN TEXT)');
    }, version: 1);

    final List<Map<String, dynamic>> query = await DataBase.query("Jobs");

    for (var element in query) {
      if (mounted) {
        Provider.of<MyJobApplicationsModel>(
          context,
          listen: false,
        ).add(JobApplicationModel(
            element["company"],
            element["name"],
            element["resume"],
            DateFormat("dd/MM/yyyy").parse(element["birthDate"]),
            element["salary"],
            element["email"],
            element["linkedIN"]));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _index = index;
    });
  }
}
