import 'dart:convert';

import 'package:troom/Models/ZoomMeeting/ShowMeeting/ShowMeetingResData.dart';

ShowMeetingRes showMeetingResFromJson(String str) => ShowMeetingRes.fromJson(json.decode(str));

String showMeetingResToJson(ShowMeetingRes data) => json.encode(data.toJson());

class ShowMeetingRes {
  ShowMeetingRes({
    this.data,
    this.status,
    this.massage,
  });

  ShowMeetingResData data;
  bool status;
  List<String> massage;

  factory ShowMeetingRes.fromJson(Map<String, dynamic> json) => ShowMeetingRes(
    data:json["data"] == null ? null : ShowMeetingResData.fromJson(json["data"]),
    status:json["status"] == null ? null : json["status"],
    massage:json["massage"] == null ? null : List<String>.from(json["massage"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data":data == null ? null : data.toJson(),
    "status":status == null ? null : status,
    "massage":massage == null ? null : List<dynamic>.from(massage.map((x) => x)),
  };
}