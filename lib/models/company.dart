class CompanyModel {
  final int Id;
  final String Name;

  CompanyModel(this.Id, this.Name);

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(int.parse(json["id"]), json["name"]);
  }
}
