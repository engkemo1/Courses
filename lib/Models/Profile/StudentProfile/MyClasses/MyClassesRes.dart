import 'dart:convert';

import 'package:troom/Models/Profile/StudentProfile/MyClasses/MyClassesResData.dart';

MyClassesRes myClassesResFromJson(String str) => MyClassesRes.fromJson(json.decode(str));

String myClassesResToJson(MyClassesRes data) => json.encode(data.toJson());

class MyClassesRes {
  MyClassesRes({
    this.data,
    this.status,
    this.massage,
  });

  List<MyClassesResData> data;
  bool status;
  List<String> massage;

  factory MyClassesRes.fromJson(Map<String, dynamic> json) => MyClassesRes(
    data:json["data"] == null ? null :
    List<MyClassesResData>.from(json["data"].map((x) => MyClassesResData.fromJson(x))),
    status:json["status"] == null ? null : json["status"],
    massage:json["massage"] == null ? null : List<String>.from(json["massage"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data":data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "status":status == null ? null : status,
    "massage":massage == null ? null : List<dynamic>.from(massage.map((x) => x)),
  };
}
