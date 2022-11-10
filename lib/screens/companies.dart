import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_aula/models/company.dart';
import 'package:http/http.dart' as http;

import 'form.dart';

class CompaniesList extends StatefulWidget {
  CompaniesList({Key? key}) : super(key: key);

  @override
  State<CompaniesList> createState() => _CompaniesListState();
}

class _CompaniesListState extends State<CompaniesList> {
  late Future<List<CompanyModel>> companies;

  @override
  void initState() {
    super.initState();
    companies = setCompanies();
  }

  Future<List<CompanyModel>> setCompanies() async {
    final response = await http.get(Uri.parse(
        "https://63541afbe64783fa827f6418.mockapi.io/pjam/companies/"));
    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body);
      List<CompanyModel> companiesAux = [];
      for (var j in json) {
        companiesAux.add(CompanyModel.fromJson(j));
      }
      return companiesAux;
    } else {
      throw Exception(" Failed load companies");
    }
  }

  @override
  Widget build(BuildContext context) {
    final border = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    );

    return Navigator(
      pages: [
        MaterialPage(
            key: const ValueKey('Companies'),
            child: FutureBuilder<List<CompanyModel>>(
              future: companies,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: [
                      for (var company in snapshot.data!)
                        Container(
                          decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide())),
                          child: ListTile(
                            shape: border,
                            title: Text(company.Name),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MyForm(title: company.Name)),
                              );
                            },
                          ),
                        )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("Error!!");
                }
                return CircularProgressIndicator();
              },
            )),
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
