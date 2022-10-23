import 'package:flutter/material.dart';

import 'form.dart';

class CompaniesList extends StatelessWidget {
  CompaniesList({Key? key}) : super(key: key);

  final List<String> _companies = [
    "Talkdesk",
    "Farfetch",
    "Blip",
    "Natixis",
    "Deloitte"
  ];

  @override
  Widget build(BuildContext context) {
    final border = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    );

    return Navigator(
      pages: [
        MaterialPage(
          key: const ValueKey('Companies'),
          child: ListView(
            children: [
              for (var company in _companies)
                Container(
                  decoration:
                      const BoxDecoration(border: Border(bottom: BorderSide())),
                  child: ListTile(
                    shape: border,
                    title: Text(company),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => MyForm(title: company)),
                      );
                    },
                  ),
                )
            ],
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
