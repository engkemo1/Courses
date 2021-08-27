import 'dart:convert';

import 'package:troom/Models/Category/CategoryResData.dart';

CategoryRes categoryResFromJson(String str) => CategoryRes.fromJson(json.decode(str));

String categoryResToJson(CategoryRes data) => json.encode(data.toJson());

class CategoryRes {
  CategoryRes({
    this.data,
    this.status,
    this.massage,
  });

  List<CategoryResData> data;
  bool status;
  List<String> massage;

  factory CategoryRes.fromJson(Map<String, dynamic> json) => CategoryRes(
    data: json["data"] == null ? null :  List<CategoryResData>.from(json["data"].map((x) => CategoryResData.fromJson(x))),
    status: json["status"] == null ? null :   json["status"],
    massage: json["massage"] == null ? null :   List<String>.from(json["massage"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status == null ? null :  status,
    "massage": massage == null ? null :  List<dynamic>.from(massage.map((x) => x)),
  };
}
