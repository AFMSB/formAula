import 'package:flutter/material.dart';
import 'package:form_aula/components/slider.dart';
import 'package:form_aula/models/jobApplication.dart';
import 'package:provider/provider.dart';

import '../components/datePicker.dart';
import '../models/myApplications.dart';

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
                        hintText: 'Diz-nos quem és!',
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
                          return 'Email inválido';
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
                          return 'Linkedin inválido';
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
                          Provider.of<MyJobApplicationsModel>(
                            context,
                            listen: false,
                          ).add(
                            JobApplicationModel(widget.title, nome, resumo,
                                data, expectativa, email, linkedin),
                          );
                          // Show confirmation dialog
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Candidatura submetida'),
                              content: Text(
                                  'A sua candidatura foi submetida com sucesso à ${widget.title}.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop('OK');
                                    Navigator.of(context).pop('Return');
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
