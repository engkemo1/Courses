import 'package:troom/Models/PlacementKey/GetPlacementKey/GetPlacementTestKeyResData.dart';

class GetPlacementTestKeyRes {
  GetPlacementTestKeyResData data;
  bool status;
  List<String> massage;

  GetPlacementTestKeyRes({this.data, this.status, this.massage});

  GetPlacementTestKeyRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new GetPlacementTestKeyResData.fromJson(json['data']) : null;
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