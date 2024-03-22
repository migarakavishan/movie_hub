class CompanyModel {
  int id;
  String? logo;
  String name;

  CompanyModel({required this.id, required this.name, required this.logo});

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
        id: json['id'], name: json['name'], logo: json['logo_path']);
  }
}
