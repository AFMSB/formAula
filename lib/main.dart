import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:form_aula/components/datePicker.dart';
import 'package:form_aula/result_page.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(const MyApp());
}

class _MyAppState extends State<MyApp> {
  Candidatura _candidatura = new Candidatura("", "", DateTime.now());

  handleOnSubmit(Candidatura candidatura) {
    setState(() {
      _candidatura = candidatura;
    });
  }

  datePickerCallback(value) {
    setState(() {
      _candidatura.data = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Candidatura Espontanea',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Navigator(
        pages: [
          MaterialPage(
              key: ValueKey('pagina_candidatura'),
              child: MyHomePage(
                  callback: handleOnSubmit(new Candidatura("", "", DateTime.now())),
                  title: 'Candidatura Espontanea',
              )
          ),
          if(_candidatura.nome != '')
            MaterialPage(
              key: ValueKey("MyAppPage"),
              child: ResultPage(candidatura: _candidatura)
            )
        ],
        onPopPage: (route, result){
          if(!route.didPop(result)){
            return false;
          }return true;
        },
      ),
      // const MyHomePage(title: 'Candidatura Espontanea'),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class Candidatura {
  String nome;
  String resumo;
  DateTime data;

  Candidatura(this.nome, this.resumo, this.data);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.callback}) : super(key: key);
  final String title;
  final Function(dynamic value) callback;

  @override
  State<MyHomePage> createState() => _MyHomePageState(callback: callback);
}

class _MyHomePageState extends State<MyHomePage> {

  _MyHomePageState({Key? key, required this.callback});
  final Function(dynamic value) callback;

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: myController,
                decoration: InputDecoration(
                    labelText: 'Nome',
                    hintText: 'Escreva o seu nome'
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    //_candidatura.resumo = value;
                  });
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.blue,
                            width: 5.0,
                            style: BorderStyle.solid)
                    ),
                    hintText: 'Resumo'
                ),
                maxLines: 5,
              ),
              MyDatePicker(datePickerCallback: (value) {
                callback(value);
              },
              ),
              ElevatedButton(
                  onPressed: (){
                    print(myController.text);
                    //handleOnSubmit(_candidatura);
                  },
                  child: Text('Submit')
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
