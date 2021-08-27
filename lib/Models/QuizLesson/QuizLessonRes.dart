import 'dart:convert';

import 'package:troom/Models/QuizLesson/QuizLessonResData.dart';

QuizLessonRes quizLessonResFromJson(String str) => QuizLessonRes.fromJson(json.decode(str));

String quizLessonResToJson(QuizLessonRes data) => json.encode(data.toJson());

class QuizLessonRes {
  QuizLessonRes({
    this.data,
    this.status,
    this.massage,
  });

  List<QuizLessonResData> data;
  bool status;
  List<String> massage;

  factory QuizLessonRes.fromJson(Map<String, dynamic> json) => QuizLessonRes(
    data:json["data"] == null ? null :
    List<QuizLessonResData>.from(json["data"].map((x) => QuizLessonResData.fromJson(x))),
    status:json["status"] == null ? null : json["status"],
    massage:json["massage"] == null ? null : List<String>.from(json["massage"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data":data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "status":status == null ? null : status,
    "massage":massage == null ? null : List<dynamic>.from(massage.map((x) => x)),
  };
}
