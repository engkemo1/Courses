import 'dart:convert';

import 'package:troom/Models/ZoomMeeting/ZoomCredential/ZoomCredResData.dart';

ZoomCredRes zoomCredResFromJson(String str) => ZoomCredRes.fromJson(json.decode(str));

String zoomCredResToJson(ZoomCredRes data) => json.encode(data.toJson());

class ZoomCredRes {
  ZoomCredRes({
    this.data,
    this.status,
    this.massage,
  });

  ZoomCredResData data;
  bool status;
  List<String> massage;

  factory ZoomCredRes.fromJson(Map<String, dynamic> json) => ZoomCredRes(
    data:json["data"] == null ? null : ZoomCredResData.fromJson(json["data"]),
    status:json["status"] == null ? null : json["status"],
    massage:json["massage"] == null ? null : List<String>.from(json["massage"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data":data == null ? null : data.toJson(),
    "status":status == null ? null : status,
    "massage":massage == null ? null : List<dynamic>.from(massage.map((x) => x)),
  };
}