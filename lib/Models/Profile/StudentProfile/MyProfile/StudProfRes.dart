import 'dart:convert';

import 'package:troom/Models/Profile/StudentProfile/MyProfile/StudProfResData.dart';

StudProfRes studProfResFromJson(String str) => StudProfRes.fromJson(json.decode(str));

String studProfResToJson(StudProfRes data) => json.encode(data.toJson());

class StudProfRes {
  StudProfRes({
    this.data,
    this.status,
    this.massage,
  });

  StudProfResData data;
  bool status;
  List<String> massage;

  factory StudProfRes.fromJson(Map<String, dynamic> json) => StudProfRes(
    data:json["data"] == null ? null : StudProfResData.fromJson(json["data"]),
    status:json["status"] == null ? null : json["status"],
    massage:json["massage"] == null ? null : List<String>.from(json["massage"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data":data == null ? null : data.toJson(),
    "status":status == null ? null : status,
    "massage":massage == null ? null : List<dynamic>.from(massage.map((x) => x)),
  };
}