class CompanyModel {
  final int id;
  final String name;

  CompanyModel(this.id, this.name);

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(int.parse(json["id"]), json["name"]);
  }
}
