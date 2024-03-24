class ActorModel {
  String name;
  String? character;
  String? image;
  int id;

  ActorModel({required this.name, required this.id, this.character, this.image});

  factory ActorModel.fromJson(Map<String, dynamic> json) {
    return ActorModel(
      name: json['name'],
      id: json['id'],
      image: json['profile_path']
    );
  }


}
