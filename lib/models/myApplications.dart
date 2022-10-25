import 'package:flutter/material.dart';
import 'package:form_aula/models/jobApplication.dart';

class MyJobApplicationsModel extends ChangeNotifier {
  final Map<String, JobApplicationModel> _myApplications = Map.identity();

  Map<String, JobApplicationModel> get applications => _myApplications;

  void add(JobApplicationModel application) {
    _myApplications[application.company] = application;
    notifyListeners();
  }
}
