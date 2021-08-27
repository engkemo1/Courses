import 'dart:convert';

import 'package:troom/Models/LessonData/LessonDataResData.dart';

LessonDataRes lessonDataResFromJson(String str) => LessonDataRes.fromJson(json.decode(str));

String lessonDataResToJson(LessonDataRes data) => json.encode(data.toJson());

class LessonDataRes {
  LessonDataRes({
    this.data,
    this.status,
    this.massage,
  });

  LessonDataResData data;
  bool status;
  List<String> massage;

  factory LessonDataRes.fromJson(Map<String, dynamic> json) => LessonDataRes(
    data:json["data"] == null ? null : LessonDataResData.fromJson(json["data"]),
    status:json["status"] == null ? null :  json["status"],
    massage:json["massage"] == null ? null :  List<String>.from(json["massage"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data":data == null ? null : data.toJson(),
    "status":status == null ? null :  status,
    "massage":massage == null ? null :  List<dynamic>.from(massage.map((x) => x)),
  };
}