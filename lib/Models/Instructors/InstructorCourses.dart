import 'dart:ffi';

import 'package:troom/Models/Instructors/InstructorsDetails.dart';

class InstructorCourses {
  InstructorCourses(
      {this.key,
      this.name,
      this.slug,
      this.image,
      this.short_description,
      this.price,
      this.level,
      this.discountPrice,
      this.teachers});

  int key;

  String name;
  String slug;
  String image;
  String short_description;
  int price;
  String level;
  int discountPrice;
  List<InstData> teachers;

  factory InstructorCourses.fromJson(Map<String, dynamic> json) =>
      InstructorCourses(
        key: json["key"] == null ? null : json["key"],
        name: json["name"] == null ? null : json["name"],
        slug: json["slug"] == null ? null : json["slug"],
        image: json["image"] == null ? null : json["image"],
        short_description: json["short_description"] == null
            ? null
            : json["short_description"],
        price: json["price"] == null ? null : json["price"],
        level: json["level"] == null ? null : json["level"],
        discountPrice:
            json["discountPrice"] == null ? null : json["discountPrice"],
        teachers: json["teachers"] == null
            ? null
            : List<InstData>.from(
                json["teachers"].map((x) => InstData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "name": name == null ? null : name,
        "slug": slug == null ? null : slug,
        "image": image == null ? null : image,
        "short_description":
            short_description == null ? null : short_description,
        "price": price == null ? null : price,
        "level": level == null ? null : level,
        "discountPrice": discountPrice == null ? null : discountPrice,
        "teachers": teachers == null
            ? null
            : List<dynamic>.from(teachers.map((x) => x.toJson())),
      };
}
