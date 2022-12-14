import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_aula/components/slider.dart';
import 'package:form_aula/models/job_application.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import '../components/date_picker.dart';
import '../models/my_applications.dart';

class MyForm extends StatefulWidget {
  final String title;

  const MyForm({required this.title, super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  String nome = '';
  String resumo = '';
  DateTime data = DateTime.now();
  double expectativa = 800;
  String email = '';
  String linkedin = '';

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  bool validatorsOn = false;

  Future<void> submitApplication(JobApplicationModel applicationModel) async {
    final response = await http.post(
        Uri.parse(
            "https://63541afbe64783fa827f6418.mockapi.io/pjam/jobapplications"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "company": widget.title,
          'createdAt': DateFormat("dd/MM/yyyy").format(DateTime.now()),
          'name': applicationModel.name,
          'resume': applicationModel.resume,
          'birthdate':
              DateFormat("dd/MM/yyyy").format(applicationModel.birthdate),
          'salary': applicationModel.salary.toString(),
          'email': applicationModel.email,
          'linkedin': applicationModel.linkedin
        }));

    if (response.statusCode != 201) {
      throw Exception("Error storing the application");
    }
    final dataBase =
        await openDatabase(join(await getDatabasesPath(), "jobApplications.db"),
            onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE Jobs (id INTEGER PRIMARY KEY, company TEXT, name TEXT, resume TEXT, birthDate TEXT, salary REAL, email TEXT, linkedIN TEXT)');
    }, version: 1);

    dataBase.insert("Jobs", applicationModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Form(
          key: _formKey,
          child: Center(
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                          filled: true,
                          labelText: 'Nome',
                          hintText: 'Escreva o seu nome'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Escreva o seu nome';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          nome = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color: Colors.blue,
                                width: 5.0,
                                style: BorderStyle.solid)),
                        hintText: 'Diz-nos quem ??s!',
                        labelText: 'Resumo pessoal e profissional',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Escreva o seu resumo pessoal e profissional';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          resumo = value;
                        });
                      },
                      maxLines: 10,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyDatePicker(
                        data: data,
                        onChanged: (value) {
                          setState(() {
                            data = value;
                          });
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    MySlider(
                        value: expectativa,
                        onChanged: (value) {
                          setState(() {
                            expectativa = value;
                          });
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        filled: true,
                        hintText: 'Insira o seu e-mail',
                        labelText: 'E-mail',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Escreva o seu email';
                        }
                        if (!validatorsOn) return null;
                        final emailRegExp =
                            RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                        if (!emailRegExp.hasMatch(value)) {
                          return 'Email inv??lido';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        filled: true,
                        hintText: 'Link para o Linkedin',
                        labelText: 'LinkedIn',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Escreva o seu Linkedin';
                        }
                        if (!validatorsOn) return null;
                        final emailRegExp = RegExp(
                            r"((https?:\/\/)?((www|\w\w)\.)?linkedin\.com\/)((([\w]{2,3})?)|([^\/]+\/(([\w|\d-&#?=])+\/?){1,}))$");
                        if (!emailRegExp.hasMatch(value)) {
                          return 'Linkedin inv??lido';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          linkedin = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          JobApplicationModel newApplication =
                              JobApplicationModel(widget.title, nome, resumo,
                                  data, expectativa, email, linkedin);
                          submitApplication(newApplication);
                          Provider.of<MyJobApplicationsModel>(
                            context,
                            listen: false,
                          ).add(newApplication);
                          // Show confirmation dialog
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Candidatura submetida'),
                              content: Text(
                                  'A sua candidatura foi submetida com sucesso ?? ${widget.title}.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop('OK');
                                    // Navigator.of(context).pop('Return');
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      child: const Text('Submeter'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
