import 'dart:convert';

import 'package:troom/Models/Footer/FooterResData.dart';

FooterRes footerResFromJson(String str) => FooterRes.fromJson(json.decode(str));

String footerResToJson(FooterRes data) => json.encode(data.toJson());

class FooterRes {
  FooterRes({
    this.data,
    this.status,
    this.massage,
  });

  FooterResData data;
  bool status;
  List<String> massage;

  factory FooterRes.fromJson(Map<String, dynamic> json) => FooterRes(
    data:json["data"] == null ? null : FooterResData.fromJson(json["data"]),
    status:json["status"] == null ? null :  json["status"],
    massage:json["massage"] == null ? null :  List<String>.from(json["massage"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data":data == null ? null : data.toJson(),
    "status":status == null ? null :  status,
    "massage":massage == null ? null :  List<dynamic>.from(massage.map((x) => x)),
  };
}
