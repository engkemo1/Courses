import 'dart:convert';

import 'package:troom/Models/ContactUs/ContactUsMassege/ContactUsMsgResData.dart';

ContactUsMsgRes contactUsMsgResFromJson(String str) => ContactUsMsgRes.fromJson(json.decode(str));

String contactUsMsgResToJson(ContactUsMsgRes data) => json.encode(data.toJson());

class ContactUsMsgRes {
  ContactUsMsgRes({
    this.data,
    this.status,
    this.massage,
  });

  ContactUsMsgResData data;
  bool status;
  List<String> massage;

  factory ContactUsMsgRes.fromJson(Map<String, dynamic> json) => ContactUsMsgRes(
    data:json["data"] == null ? null : ContactUsMsgResData.fromJson(json["data"]),
    status:json["status"] == null ? null : json["status"],
    massage:json["massage"] == null ? null : List<String>.from(json["massage"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data":data == null ? null : data.toJson(),
    "status":status == null ? null : status,
    "massage":massage == null ? null : List<dynamic>.from(massage.map((x) => x)),
  };
}