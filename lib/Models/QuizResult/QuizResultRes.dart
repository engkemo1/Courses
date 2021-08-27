import 'dart:convert';

import 'package:troom/Models/QuizResult/QuizResultResData.dart';

QuizResultRes quizResultResFromJson(String str) => QuizResultRes.fromJson(json.decode(str));

String quizResultResToJson(QuizResultRes data) => json.encode(data.toJson());

class QuizResultRes {
  QuizResultRes({
    this.data,
    this.status,
    this.massage,
  });

  QuizResultResData data;
  bool status;
  List<String> massage;

  factory QuizResultRes.fromJson(Map<String, dynamic> json) => QuizResultRes(
    data:json["data"] == null ? null : QuizResultResData.fromJson(json["data"]),
    status:json["status"] == null ? null : json["status"],
    massage:json["massage"] == null ? null : List<String>.from(json["massage"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data":data == null ? null : data.toJson(),
    "status":status == null ? null : status,
    "massage":massage == null ? null : List<dynamic>.from(massage.map((x) => x)),
  };
}
