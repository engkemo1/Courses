import 'dart:convert';

import 'package:troom/Models/Auth/Login/LoginResDataFalse.dart';

LoginResFalse loginResFalseFromJson(String str) => LoginResFalse.fromJson(json.decode(str));

String loginResFalseToJson(LoginResFalse data) => json.encode(data.toJson());

class LoginResFalse {
  LoginResFalse({
    this.data,
    this.status,
    this.massage,
  });

  LoginResDataFalse data;
  bool status;
  List<String> massage;

  factory LoginResFalse.fromJson(Map<String, dynamic> json) => LoginResFalse(
    data:json["data"] == null ? null : LoginResDataFalse.fromJson(json["data"]),
    status:json["status"] == null ? null : json["status"],
    massage:json["massage"] == null ? null : List<String>.from(json["massage"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data":data ==null ? null : data.toJson(),
    "status":status ==null ? null : status,
    "massage":massage ==null ? null : List<dynamic>.from(massage.map((x) => x)),
  };
}

