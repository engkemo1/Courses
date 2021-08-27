import 'dart:convert';

import 'package:troom/Models/Auth/Login/LoginResData.dart';


LoginRes loginResFromJson(String str) => LoginRes.fromJson(json.decode(str));

String loginResToJson(LoginRes data) => json.encode(data.toJson());

class LoginRes {
  LoginRes({
    this.data,
    this.status,
    this.massage,
  });

  LoginResData data;
  bool status;
  List<String> massage;

  factory LoginRes.fromJson(Map<String, dynamic> json) => LoginRes(
    data:json["data"] == null ? null : LoginResData.fromJson(json["data"]),
    status:json["status"] == null ? null : json["status"],
    massage:json["massage"] == null ? null : List<String>.from(json["massage"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data":data ==null ? null : data.toJson(),
    "status":status ==null ? null : status,
    "massage":massage ==null ? null : List<dynamic>.from(massage.map((x) => x)),
  };

}