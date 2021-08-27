import 'dart:convert';

import 'package:troom/Models/Auth/Register/RegisterResData.dart';


RegisterRes registerResFromJson(String str) => RegisterRes.fromJson(json.decode(str));

String registerResToJson(RegisterRes data) => json.encode(data.toJson());

class RegisterRes {
  RegisterRes({
    this.data,
    this.status,
    this.massage,
  });

  RegisterResData data;
  bool status;
  List<String> massage;

  factory RegisterRes.fromJson(Map<String, dynamic> json) => RegisterRes(
    data:json["data"] == null ? null : RegisterResData.fromJson(json["data"]),
    status:json["status"] == null ? null : json["status"],
    massage:json["massage"] == null ? null : List<String>.from(json["massage"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data":data == null ? null : data.toJson(),
    "status":status == null ? null : status,
    "massage":massage == null ? null : List<dynamic>.from(massage.map((x) => x)),
  };
}