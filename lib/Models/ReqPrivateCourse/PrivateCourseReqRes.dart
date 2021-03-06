import 'package:troom/Models/ReqPrivateCourse/PrivateCourseReqResData.dart';

class PrivateCourseReqRes {
  PrivateCourseReqResData data;
  bool status;
  List<String> massage;

  PrivateCourseReqRes({this.data, this.status, this.massage});

  PrivateCourseReqRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new PrivateCourseReqResData.fromJson(json['data']) : null;
    status = json['status'];
    massage = json['massage'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['status'] = this.status;
    data['massage'] = this.massage;
    return data;
  }
}
