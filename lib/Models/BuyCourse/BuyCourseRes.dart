import 'dart:convert';

import 'package:troom/Models/BuyCourse/BuyCourseResData.dart';

BuyCourseRes buyCourseResFromJson(String str) => BuyCourseRes.fromJson(json.decode(str));

String buyCourseResToJson(BuyCourseRes data) => json.encode(data.toJson());

class BuyCourseRes {
  BuyCourseRes({
    this.data,
    this.status,
    this.massage,
  });

  BuyCourseResData data;
  bool status;
  List<String> massage;

  factory BuyCourseRes.fromJson(Map<String, dynamic> json) => BuyCourseRes(
    data:json["data"] == null ? null :  BuyCourseResData.fromJson(json["data"]),
    status:json["status"] == null ? null : json["status"],
    massage:json["massage"] == null ? null : List<String>.from(json["massage"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data":data == null ? null : data.toJson(),
    "status":status == null ? null : status,
    "massage":massage == null ? null : List<dynamic>.from(massage.map((x) => x)),
  };
}