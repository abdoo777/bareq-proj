class AppString {
  static const String students = 'الطلاب';
  static const String attend = 'الحضور';
  static const String report = 'التقارير';
  static const String pdf = 'PDF';
  static const String settings = 'الإعدادات';
  static const String defaultValue = 'defaultValue';
  static const String authResason = "من فضلك قم بالتحقق ليتم الدخول للتطبيق";
  //////////////////////////////////////////////


  static const String first = 'المرحلة الأولي';
  static const String second = 'المرحلة الثانية';
  static const String third = 'المرحلة الثالثة';
  static const String forth = 'المرحلة الرابعة';
  static const String fifth = 'المرحلة الخامسة';
  static const String sixth = 'المرحلة السادسة';
/////////////////////////////////////////////

  static const String depart1 = 'الشعبة الأولي - المرحلة الاولي';
  static const String depart12 = 'الشعبة الثانية - المرحلة الاولي';


  static const String depart2 = 'الشعبة الأولي - المرحلة الثانية';
  static const String depart22 = 'الشعبة الثانية - المرحلة الثانية';


  static const String depart3 = 'الشعبة الأولي - المرحلة الثالثة';
  static const String depart33 = 'الشعبة الثانية - المرحلة الثالثة';

  static const String depart4 = 'الشعبة الأولي - المرحلة الرابعة';
  static const String depart44 = 'الشعبة الثانية - المرحلة الرابعة';





  /////////////////// Database ////////////////////////
  static const String databaseName = "students.db";
  static const int databaseVersion = 1;
  static const String tableName = "students";
  static const String tablepdf = "pdf";
  static const String attendTable = "attendance";
  static const String id = "id";
  static const String name = "name";
  static const String image = "image";
  static const String department = "department";
  static const String email = "email";
  static const String level = "level";

  static const String userId = "userId";
  static const String date = "date";
  static const String time = "time";
  static const String isAttend = "isAttend";

  static const String createDatabaseQuery =
      'CREATE TABLE $tableName ($id INTEGER PRIMARY KEY, $name TEXT, $image TEXT, $level TEXT, $email TEXT, $department Text )';
  static const String createDatabaseAttend =
      'CREATE TABLE $attendTable ($id INTEGER PRIMARY KEY, $userId INTEGER, $name TEXT, $date TEXT, $time TEXT, $isAttend INTEGER, $department Text )';
  static const String createDatabasePdf =
      'CREATE TABLE $tablepdf ($id INTEGER PRIMARY KEY, $name TEXT, $pdf BLOC )';
}














