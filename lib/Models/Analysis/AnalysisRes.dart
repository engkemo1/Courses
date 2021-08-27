import 'dart:convert';

import 'package:troom/Models/Analysis/AnalysisResData.dart';

AnalysisRes analysisResFromJson(String str) => AnalysisRes.fromJson(json.decode(str));

String analysisResToJson(AnalysisRes data) => json.encode(data.toJson());

class AnalysisRes {
  AnalysisRes({
    this.data,
    this.status,
    this.massage,
  });

  AnalysisResData data;
  bool status;
  List<String> massage;

  factory AnalysisRes.fromJson(Map<String, dynamic> json) => AnalysisRes(
    data:json["data"] == null ? null : AnalysisResData.fromJson(json["data"]),
    status:json["status"] == null ? null :  json["status"],
    massage:json["massage"] == null ? null :  List<String>.from(json["massage"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data":data == null ? null : data.toJson(),
    "status":status == null ? null :  status,
    "massage":massage == null ? null :  List<dynamic>.from(massage.map((x) => x)),
  };
}
