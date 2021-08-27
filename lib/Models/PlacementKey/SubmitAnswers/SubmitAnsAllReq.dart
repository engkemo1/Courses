import 'package:troom/Models/PlacementKey/SubmitAnswers/SubmitPlacementTestAnsReq.dart';

class SubmitAnsAllReq{
  int examKey;
  // List<SubmitPlacementTestAnsReq> result;
  String result;

  SubmitAnsAllReq({this.examKey,this.result});

  SubmitAnsAllReq.fromJson(Map<String, dynamic> json) {
    examKey = json['exam_key'];
    result = json["result"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exam_key'] = this.examKey;
    data['result'] = this.result;
    return data;
  }
}