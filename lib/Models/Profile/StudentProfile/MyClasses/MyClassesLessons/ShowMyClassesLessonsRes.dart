import 'dart:convert';

import 'package:troom/Models/Profile/StudentProfile/MyClasses/MyClassesLessons/ShowMyClassesLessonsResData.dart';

ShowMyClassesLessonRes showMyClassesLessonResFromJson(String str) => ShowMyClassesLessonRes.fromJson(json.decode(str));

String showMyClassesLessonResToJson(ShowMyClassesLessonRes data) => json.encode(data.toJson());

class ShowMyClassesLessonRes {
  ShowMyClassesLessonRes({
    this.data,
    this.status,
    this.massage,
  });

  List<ShowMyClassesResData> data;
  bool status;
  List<String> massage;

  factory ShowMyClassesLessonRes.fromJson(Map<String, dynamic> json) => ShowMyClassesLessonRes(
    data:json["data"] == null ? null :
    List<ShowMyClassesResData>.from(json["data"].map((x) => ShowMyClassesResData.fromJson(x))),
    status:json["status"] == null ? null : json["status"],
    massage:json["massage"] == null ? null : List<String>.from(json["massage"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data":data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "status":status == null ? null : status,
    "massage":massage == null ? null : List<dynamic>.from(massage.map((x) => x)),
  };
}
