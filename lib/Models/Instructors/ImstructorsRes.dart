import 'package:troom/Models/Instructors/InstructorCourses.dart';

class Data {
  Data({
    this.data,
  });

  List<dynamic> data;

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(data: json["data"] == null ? null : json["data"]);
}

class Courses {
  Courses({
    this.courses,
  });

  List<dynamic> courses;

  factory Courses.fromJson(Map<String, dynamic> json) =>
      Courses(courses: json["courses"] == null ? null : json["courses"]);
}
