import 'dart:convert';

import 'package:troom/Models/Auth/TokenStatus/CheckResData.dart';

CheckRes checkResFromJson(String str) => CheckRes.fromJson(json.decode(str));

String checkResToJson(CheckRes data) => json.encode(data.toJson());

class CheckRes {
  CheckRes({
    this.data,
    this.status,
    this.massage,
  });

  CheckResData data;
  bool status;
  List<String> massage;

  factory CheckRes.fromJson(Map<String, dynamic> json) => CheckRes(
    data:json["data"] == null ? null : CheckResData.fromJson(json["data"]),
    status:json["status"] == null ? null : json["status"],
    massage:json["massage"] == null ? null : List<String>.from(json["massage"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data":data == null ? null : data.toJson(),
    "status":status == null ? null : status,
    "massage":massage == null ? null : List<dynamic>.from(massage.map((x) => x)),
  };
}