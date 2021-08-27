import 'dart:convert';

LogoutRes logoutResFromJson(String str) => LogoutRes.fromJson(json.decode(str));

String logoutResToJson(LogoutRes data) => json.encode(data.toJson());

class LogoutRes {
  LogoutRes({
    this.data,
    this.status,
    this.massage,
  });

  dynamic data;
  bool status;
  List<String> massage;

  factory LogoutRes.fromJson(Map<String, dynamic> json) => LogoutRes(
    data:json["data"] == null ? null : json["data"],
    status:json["status"] == null ? null : json["status"],
    massage:json["massage"] == null ? null : List<String>.from(json["massage"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data":data == null ? null : data,
    "status":status == null ? null : status,
    "massage":massage == null ? null : List<dynamic>.from(massage.map((x) => x)),
  };
}
