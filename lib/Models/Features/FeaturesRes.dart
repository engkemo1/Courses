import 'dart:convert';

import 'package:troom/Models/Features/FeaturesResData.dart';

FeaturesRes featuresResFromJson(String str) => FeaturesRes.fromJson(json.decode(str));

String featuresResToJson(FeaturesRes data) => json.encode(data.toJson());

class FeaturesRes {
  FeaturesRes({
    this.data,
    this.status,
    this.massage,
  });

  List<FeaturesResData> data;
  bool status;
  List<String> massage;

  factory FeaturesRes.fromJson(Map<String, dynamic> json) => FeaturesRes(
    data:json["data"] == null ? null : List<FeaturesResData>.from(json["data"].map((x) => FeaturesResData.fromJson(x))),
    status: json["status"] == null ? null :  json["status"],
    massage: json["massage"] == null ? null :  List<String>.from(json["massage"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status == null ? null :  status,
    "massage":  massage == null ? null :  List<dynamic>.from(massage.map((x) => x)),
  };
}