import 'dart:convert';

import 'package:troom/Models/LiveCourseDetails/LiveCourseDetailsResData.dart';

LiveCourseDetailsRes liveCourseDetailsResFromJson(String str) => LiveCourseDetailsRes.fromJson(json.decode(str));

String liveCourseDetailsResToJson(LiveCourseDetailsRes data) => json.encode(data.toJson());

class LiveCourseDetailsRes {
  LiveCourseDetailsRes({
    this.data,
    this.status,
    this.massage,
  });

  LiveCourseDetailsResData data;
  bool status;
  List<String> massage;

  factory LiveCourseDetailsRes.fromJson(Map<String, dynamic> json) => LiveCourseDetailsRes(
    data:json["data"] == null ? null : LiveCourseDetailsResData.fromJson(json["data"]),
    status:json["status"] == null ? null : json["status"],
    massage:json["massage"] == null ? null : List<String>.from(json["massage"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data":data == null ? null : data.toJson(),
    "status":status == null ? null : status,
    "massage":massage == null ? null : List<dynamic>.from(massage.map((x) => x)),
  };
}