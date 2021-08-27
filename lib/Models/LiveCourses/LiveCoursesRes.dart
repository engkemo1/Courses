import 'dart:convert';

import 'package:troom/Models/LiveCourses/LiveCoursesResData.dart';

LiveCouresesRes liveCouresesResFromJson(String str) => LiveCouresesRes.fromJson(json.decode(str));

String liveCouresesResToJson(LiveCouresesRes data) => json.encode(data.toJson());

class LiveCouresesRes {
  LiveCouresesRes({
    this.data,
    this.status,
    this.massage,
  });

  List<LiveCourseResData> data;
  bool status;
  List<String> massage;

  factory LiveCouresesRes.fromJson(Map<String, dynamic> json) => LiveCouresesRes(
    data: json["data"] == null ? null : List<LiveCourseResData>.from(json["data"].map((x) => LiveCourseResData.fromJson(x))),
    status: json["status"] == null ? null :  json["status"],
    massage: json["massage"] == null ? null :  List<String>.from(json["massage"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data":data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "status":status == null ? null :  status,
    "massage":massage == null ? null :  List<dynamic>.from(massage.map((x) => x)),
  };
}