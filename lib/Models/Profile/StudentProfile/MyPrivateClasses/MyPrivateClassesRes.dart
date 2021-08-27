import 'package:troom/Models/Profile/StudentProfile/MyPrivateClasses/MyPrivateClassesResData.dart';

class MyPrivateClassesRes {
  List<MyPrivateClassesResData> data;
  bool status;
  List<String> massage;

  MyPrivateClassesRes({this.data, this.status, this.massage});

  MyPrivateClassesRes.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<MyPrivateClassesResData>();
      json['data'].forEach((v) {
        data.add(new MyPrivateClassesResData.fromJson(v));
      });
    }
    status = json['status'];
    massage = json['massage'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['massage'] = this.massage;
    return data;
  }
}