import 'dart:convert';

import 'package:troom/Models/AboutUs/AboutUsResData.dart';

AboutUsRes aboutUsResFromJson(String str) => AboutUsRes.fromJson(json.decode(str));

String aboutUsResToJson(AboutUsRes data) => json.encode(data.toJson());

class AboutUsRes {
  AboutUsRes({
    this.data,
    this.status,
    this.massage,
  });

  AboutUsResData data;
  bool status;
  List<String> massage;

  factory AboutUsRes.fromJson(Map<String, dynamic> json) => AboutUsRes(
    data:json["data"] == null ? null : AboutUsResData.fromJson(json["data"]),
    status:json["status"] == null ? null :  json["status"],
    massage:json["massage"] == null ? null :  List<String>.from(json["massage"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data":data == null ? null : data.toJson(),
    "status": status == null ? null : status,
    "massage": massage == null ? null : List<dynamic>.from(massage.map((x) => x)),
  };
}
