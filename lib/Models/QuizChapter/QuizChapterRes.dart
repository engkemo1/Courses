import 'dart:convert';

import 'package:troom/Models/QuizChapter/QuizChapterResData.dart';

QuizChapterRes quizChapterResFromJson(String str) => QuizChapterRes.fromJson(json.decode(str));

String quizChapterResToJson(QuizChapterRes data) => json.encode(data.toJson());

class QuizChapterRes {
  QuizChapterRes({
    this.data,
    this.status,
    this.massage,
  });

  List<QuizChapterResData> data;
  bool status;
  List<String> massage;

  factory QuizChapterRes.fromJson(Map<String, dynamic> json) => QuizChapterRes(
    data:json["data"] == null ? null :
    List<QuizChapterResData>.from(json["data"].map((x) => QuizChapterResData.fromJson(x))),
    status:json["status"] == null ? null :  json["status"],
    massage:json["massage"] == null ? null :  List<String>.from(json["massage"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data":data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "status":status == null ? null : status,
    "massage":massage == null ? null : List<dynamic>.from(massage.map((x) => x)),
  };
}