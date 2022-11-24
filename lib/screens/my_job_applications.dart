import 'package:flutter/material.dart';
import 'package:form_aula/models/my_applications.dart';
import 'package:provider/provider.dart';

import 'job_application.dart';

class MyJobApplications extends StatelessWidget {
  const MyJobApplications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final border = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    );

    return Navigator(
      pages: [
        MaterialPage(
          key: const ValueKey('Companies'),
          child: Consumer<MyJobApplicationsModel>(
            builder: (context, myApplications, child) => ListView(
              children: myApplications.applications.entries.map((entry) {
                return Container(
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide())),
                    child: ListTile(
                        shape: border,
                        title: Text(entry.key),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => JobApplication(
                                candidatura: entry.value,
                              ),
                            ),
                          );
                        }));
              }).toList(),
            ),
          ),
        ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        return true;
      },
    );
  }
}
