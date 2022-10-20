import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import 'main.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key, required this.candidatura}) : super(key: key);

  final Candidatura candidatura;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Some Text'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left:20, right: 20, top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(candidatura.nome),
              SizedBox(
                height: 20,
              ),
              Text(candidatura.resumo),
              Text(intl.DateFormat("dd/MM/yyyy").format(candidatura.data)),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
