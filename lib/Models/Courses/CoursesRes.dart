import 'dart:convert';

import 'package:troom/Models/Courses/CoursesResData.dart';

CoursesRes coursesResFromJson(String str) => CoursesRes.fromJson(json.decode(str));

String coursesResToJson(CoursesRes data) => json.encode(data.toJson());

class CoursesRes {
  CoursesRes({
    this.data,
    this.status,
    this.massage,
  });

  List<CoursesResData> data;
  bool status;
  List<String> massage;

  factory CoursesRes.fromJson(Map<String, dynamic> json) => CoursesRes(
    data:json["data"] == null ? null : List<CoursesResData>.from(json["data"].map((x) => CoursesResData.fromJson(x))),
    status:json["status"] == null ? null : json["status"],
    massage:json["massage"] == null ? null : List<String>.from(json["massage"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data":data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "status":status == null ? null :  status,
    "massage":massage == null ? null :  List<dynamic>.from(massage.map((x) => x)),
  };
}
