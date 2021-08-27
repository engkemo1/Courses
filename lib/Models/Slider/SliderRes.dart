import 'dart:convert';

import 'package:troom/Models/Slider/SliderResData.dart';

SliderRes sliderResFromJson(String str) => SliderRes.fromJson(json.decode(str));

String sliderResToJson(SliderRes data) => json.encode(data.toJson());

class SliderRes {
  SliderRes({
    this.data,
    this.status,
    this.massage,
  });

  List<SliderResData> data;
  bool status;
  List<String> massage;

  factory SliderRes.fromJson(Map<String, dynamic> json) => SliderRes(
    data: json["data"] == null ? null : List<SliderResData>.from(json["data"].map((x) => SliderResData.fromJson(x))),
    status:json["status"] == null ? null : json["status"],
    massage: json["message"] == null ? null : List<String>.from(json["massage"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status == null ? null :  status,
    "massage": massage == null ? null :  List<dynamic>.from(massage.map((x) => x)),
  };
}

