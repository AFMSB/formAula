import 'package:flutter/material.dart';

import '../models/job_application.dart';

class JobApplication extends StatelessWidget {
  final JobApplicationModel candidatura;

  const JobApplication({Key? key, required this.candidatura}) : super(key: key);

  final TextStyle _textStyle = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(candidatura.company),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
          child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: candidatura
                  .toStringList()
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Text(style: _textStyle, e),
                    ),
                  )
                  .toList()

              /*ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Back'))
              ]*/

              ),
        ),
      ),
    );
    // This trailing comma makes auto-formatting nicer for build methods.
  }
}
