import 'package:flutter/material.dart';

import 'components/datePicker.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(
                    labelText: 'Nome', hintText: 'Escreva o seu nome'),
                onChanged: (value){
                  setState(() {
                    nome = value;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 5.0,
                            style: BorderStyle.solid)),
                    hintText: 'Resumo'),
                    onChanged: (value) {
                      setState(() {
                        resumo = value;
                      });
                    },
                maxLines: 5,
              ),
              MyDatePicker(data: data, onChanged: (value) {
                setState(() {
                  data = value;
                });
              }),
              ElevatedButton(
                  onPressed: () {
                    widget.callback({nome, resumo, data});
                  },
                  child: const Text('Submeter'))
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
