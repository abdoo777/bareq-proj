class AttendModel {
  int? userId;
  String ? name;
  String? date;
  String? time;
  int? isAttend;
  String? department;

  AttendModel({
    required this.userId,
    required this.date,
    required this.time,
    required this.name,
    required this.isAttend,
    required this.department,
  });

  AttendModel.fromJson({required Map<String, dynamic> json}) {
    userId = json["userId"];
    date = json["date"];
    name = json["name"];
    time = json["time"];
    isAttend = json["isAttend"];
    department = json["department"];
  }

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "date": date,
      "name": name,
      "time": time,
      "isAttend": isAttend,
      "department": department,
    };
  }
}
