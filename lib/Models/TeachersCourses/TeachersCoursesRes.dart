import 'dart:convert';

import 'package:troom/Models/TeachersCourses/TeachersCoursesResData.dart';

TeachersCoursesRes teachersCoursesResFromJson(String str) => TeachersCoursesRes.fromJson(json.decode(str));

String teachersCoursesResToJson(TeachersCoursesRes data) => json.encode(data.toJson());

class TeachersCoursesRes {
  TeachersCoursesRes({
    this.data,
    this.status,
    this.massage,
  });

  List<TeachersCoursesResData> data;
  bool status;
  List<String> massage;

  factory TeachersCoursesRes.fromJson(Map<String, dynamic> json) => TeachersCoursesRes(
    data: List<TeachersCoursesResData>.from(json["data"].map((x) => TeachersCoursesResData.fromJson(x))),
    status: json["status"],
    massage: List<String>.from(json["massage"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
    "massage": List<dynamic>.from(massage.map((x) => x)),
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeachersCoursesRes &&
          runtimeType == other.runtimeType &&
          data == other.data &&
          status == other.status &&
          massage == other.massage;

  @override
  int get hashCode => data.hashCode ^ status.hashCode ^ massage.hashCode;
}