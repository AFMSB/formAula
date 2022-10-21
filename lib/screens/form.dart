import 'package:flutter/material.dart';
import 'package:form_aula/components/slider.dart';
import 'package:intl/intl.dart' as intl;

import '../components/datePicker.dart';

class MyForm extends StatefulWidget {
  final String title;
  final ValueChanged callback;

  const MyForm({required this.title, required this.callback, super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Form(
          key: _formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                        filled: true,
                        labelText: 'Nome',
                        hintText: 'Escreva o seu nome'),
                    onChanged: (value) {
                      setState(() {
                        nome = value;
                      });
                    },
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
                    onChanged: (value) {
                      setState(() {
                        resumo = value;
                      });
                    },
                    maxLines: 10,
                  ),
                  MyDatePicker(
                      data: data,
                      onChanged: (value) {
                        setState(() {
                          data = value;
                        });
                      }),
                  MySlider(
                      value: expectativa,
                      onChanged: (value) {
                        setState(() {
                          expectativa = value;
                        });
                      }),
                  TextFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Insira o seu e-mail',
                      labelText: 'E-mail',
                    ),
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Link para o Linkedin',
                      labelText: 'LinkedIn',
                    ),
                    onChanged: (value) {
                      setState(() {
                        linkedin = value;
                      });
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, otherwise false.
                        if (_formKey.currentState!.validate()) {
                          widget.callback({
                            nome,
                            resumo,
                            intl.DateFormat("dd/MM/yyyy").format(data),
                            expectativa.toString(),
                            email,
                            linkedin
                          });
                        }
                      },
                      child: const Text('Submeter'))
                ],
              ),
            ),
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
