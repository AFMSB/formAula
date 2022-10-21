import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class ResultPage extends StatelessWidget {
  final List<dynamic> candidatura;

  const ResultPage({Key? key, required this.candidatura}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumo da candidatura'),
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
            child: Column(
              children: [
                Text("Nome: ${candidatura.elementAt(0)}"),
                Text("Resumo: ${candidatura.elementAt(1)}"),
                Text(
                    "Data de nascimento: ${intl.DateFormat("dd/MM/yyyy").format(candidatura.elementAt(2))}"),
              ],
            )),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
