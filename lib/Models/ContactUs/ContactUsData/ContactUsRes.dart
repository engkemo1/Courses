import 'dart:convert';

import 'package:troom/Models/ContactUs/ContactUsData/ContactUsResData.dart';

ContactUsRes contactUsResFromJson(String str) => ContactUsRes.fromJson(json.decode(str));

String contactUsResToJson(ContactUsRes data) => json.encode(data.toJson());

class ContactUsRes {
  ContactUsRes({
    this.data,
    this.status,
    this.massage,
  });

  ContactUsResData data;
  bool status;
  List<String> massage;

  factory ContactUsRes.fromJson(Map<String, dynamic> json) => ContactUsRes(
    data:json["data"] == null ? null : ContactUsResData.fromJson(json["data"]),
    status:json["status"] == null ? null : json["status"],
    massage:json["massage"] == null ? null : List<String>.from(json["massage"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data":data == null ? null : data.toJson(),
    "status":status == null ? null : status,
    "massage":massage == null ? null : List<dynamic>.from(massage.map((x) => x)),
  };
}