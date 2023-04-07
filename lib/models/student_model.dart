class StudentModel {
  int? id;
  String? name;
  String? deparment;
  String? level;
  String? image;
  String? email;

  StudentModel(
      {required this.id,
      required this.name,
      required this.deparment,
      required this.email,
      required this.level,
      required this.image});

  StudentModel.fromJson(Map<String, dynamic> map) {
    id = map["id"];
    name = map["name"];
    deparment = map["deparment"];
    email = map["email"];
    level = map["level"];
    image = map["image"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "deparment": deparment,
      "email": email,
      "level": level,
      "image": image,
    };
  }
}
