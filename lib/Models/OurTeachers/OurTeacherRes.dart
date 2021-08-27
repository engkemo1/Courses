import 'dart:convert';

import 'package:troom/Models/OurTeachers/OurTeachersResData.dart';

OurTeacherRes ourTeacherResFromJson(String str) => OurTeacherRes.fromJson(json.decode(str));

String ourTeacherResToJson(OurTeacherRes data) => json.encode(data.toJson());

class OurTeacherRes {


  OurTeacherRes({
    this.data,
    this.status,
    this.massage,
  });

  List<OurTeachersResData> data;
  bool status;
  List<String> massage;


  factory OurTeacherRes.fromJson(Map<String, dynamic> json) => OurTeacherRes(
    data: json["data"] == null ? null :  List<OurTeachersResData>.from(json["data"].map((x) => OurTeachersResData.fromJson(x))),
    status: json["status"] == null ? null : json["status"],
    massage:  json["massage"] == null ? null : List<String>.from(json["massage"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data":data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "status":status == null ? null :  status,
    "massage":massage == null ? null :  List<dynamic>.from(massage.map((x) => x)),
  };
}