import 'package:flutter/material.dart';

class JobApplication extends StatelessWidget {
  final List<dynamic> candidatura;

  const JobApplication({Key? key, required this.candidatura}) : super(key: key);

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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: candidatura
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(e),
                        ),
                      )
                      .toList(),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Back'))
              ]),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
