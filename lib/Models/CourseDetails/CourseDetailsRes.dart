import 'dart:convert';

import 'package:troom/Models/CourseDetails/CourseDetailsResData.dart';

CourseDetailsRes courseDetailsResFromJson(String str) => CourseDetailsRes.fromJson(json.decode(str));

String courseDetailsResToJson(CourseDetailsRes data) => json.encode(data.toJson());

class CourseDetailsRes {
  CourseDetailsRes({
    this.data,
    this.status,
    this.massage,
  });

  CourseDetailsResData data;
  bool status;
  List<String> massage;

  factory CourseDetailsRes.fromJson(Map<String, dynamic> json) => CourseDetailsRes(
    data:json["data"] == null ? null : CourseDetailsResData.fromJson(json["data"]),
    status:json["status"] == null ? null :  json["status"],
    massage:json["massage"] == null ? null :  List<String>.from(json["massage"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data":data == null ? null : data.toJson(),
    "status":status == null ? null :  status,
    "massage":massage == null ? null :  List<dynamic>.from(massage.map((x) => x)),
  };
}
