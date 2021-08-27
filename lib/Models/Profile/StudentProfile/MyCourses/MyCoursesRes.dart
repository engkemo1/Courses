import 'dart:convert';

import 'package:troom/Models/Profile/StudentProfile/MyCourses/MyCoursesResData.dart';

MyCoursesRes myCoursesResFromJson(String str) => MyCoursesRes.fromJson(json.decode(str));

String myCoursesResToJson(MyCoursesRes data) => json.encode(data.toJson());

class MyCoursesRes {
  MyCoursesRes({
    this.data,
    this.status,
    this.massage,
  });

  List<MyCoursesResData> data;
  bool status;
  List<String> massage;

  factory MyCoursesRes.fromJson(Map<String, dynamic> json) => MyCoursesRes(
    data:json["data"] == null ? null : List<MyCoursesResData>.from(json["data"].map((x) => MyCoursesResData.fromJson(x))),
    status:json["status"] == null ? null : json["status"],
    massage:json["massage"] == null ? null : List<String>.from(json["massage"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data":data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "status":status == null ? null : status,
    "massage":massage == null ? null : List<dynamic>.from(massage.map((x) => x)),
  };
}