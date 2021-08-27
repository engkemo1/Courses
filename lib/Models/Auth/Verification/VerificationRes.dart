import 'dart:convert';

import 'package:troom/Models/Auth/Verification/VerificationResData.dart';

VerificationRes verificationResFromJson(String str) => VerificationRes.fromJson(json.decode(str));

String verificationResToJson(VerificationRes data) => json.encode(data.toJson());

class VerificationRes {
  VerificationRes({
    this.data,
    this.status,
    this.massage,
  });

  VerificationResData data;
  bool status;
  List<String> massage;

  factory VerificationRes.fromJson(Map<String, dynamic> json) => VerificationRes(
    data:json["data"] == null ? null : VerificationResData.fromJson(json["data"]),
    status:json["status"] == null ? null : json["status"],
    massage:json["massage"] == null ? null : List<String>.from(json["massage"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data":data == null ? null : data.toJson(),
    "status":status == null ? null : status,
    "massage":massage == null ? null : List<dynamic>.from(massage.map((x) => x)),
  };
}