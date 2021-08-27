import 'dart:convert';

ResendCodeRes resendCodeResFromJson(String str) => ResendCodeRes.fromJson(json.decode(str));

String resendCodeResToJson(ResendCodeRes data) => json.encode(data.toJson());

class ResendCodeRes {
  ResendCodeRes({
    this.data,
    this.status,
    this.massage,
  });

  dynamic data;
  bool status;
  List<String> massage;

  factory ResendCodeRes.fromJson(Map<String, dynamic> json) => ResendCodeRes(
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