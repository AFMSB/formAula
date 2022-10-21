import 'package:flutter/material.dart';

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
              children: candidatura.map((e) => Text(e)).toList(),
            )),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
