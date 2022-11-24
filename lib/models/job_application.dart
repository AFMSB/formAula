import 'package:intl/intl.dart';

class JobApplicationModel {
  final String _company;
  final String _name;
  final String _resume;
  final DateTime _birthdate;
  final double _salary;
  final String _email;
  final String _linkedin;

  JobApplicationModel(this._company, this._name, this._resume, this._birthdate,
      this._salary, this._email, this._linkedin);

  String get company => _company;

  String get name => _name;

  String get resume => _resume;

  DateTime get birthdate => _birthdate;

  double get salary => _salary;

  String get email => _email;

  String get linkedin => _linkedin;

  List<String> toStringList() {
    return [
      "Nome: $_name",
      "Resumo: $_resume",
      "Data de nascimento: ${DateFormat("dd/MM/yyyy").format(_birthdate)}",
      "Expectativa salarial: ${NumberFormat.currency(symbol: "€", decimalDigits: 0).format(_salary)}",
      "Email: $_email",
      "Linkedin: $_linkedin",
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      "company": _company,
      "name": _name,
      "resume": _resume,
      "birthDate": DateFormat("dd/MM/yyyy").format(_birthdate),
      "salary": _salary,
      "email": _email,
      "linkedIn": _linkedin
    };
  }
}
