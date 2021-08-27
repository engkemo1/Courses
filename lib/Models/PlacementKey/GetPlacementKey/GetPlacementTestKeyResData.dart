class GetPlacementTestKeyResData {
  int examKey;

  GetPlacementTestKeyResData({this.examKey});

  GetPlacementTestKeyResData.fromJson(Map<String, dynamic> json) {
    examKey = json['exam_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exam_key'] = this.examKey;
    return data;
  }
}