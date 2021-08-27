class LiveCourseDetailsResData {
  LiveCourseDetailsResData({
    this.key,
    this.owner,
    this.name,
    this.slug,
    this.category,
    this.subCategory,
    this.image,
    this.discountPrice,
    this.price,
    this.shortDescription,
    this.description,
    this.whatWillLearn,
    this.requirements,
    this.level,
    this.teacher,
    this.teachers,
    this.lessons,
  });

  int key;
  bool owner;
  String name;
  String slug;
  String category;
  String subCategory;
  String image;
  int discountPrice;
  int price;
  String shortDescription;
  String description;
  String whatWillLearn;
  String requirements;
  String level;
  Teacher teacher;
  List<Teacher> teachers;
  List<Lesson> lessons;

  factory LiveCourseDetailsResData.fromJson(Map<String, dynamic> json) => LiveCourseDetailsResData(
    key: json["key"],
    owner: json["owner"],
    name: json["name"],
    slug: json["slug"],
    category: json["category"],
    subCategory: json["subCategory"],
    image: json["image"],
    discountPrice: json["discountPrice"],
    price: json["price"],
    shortDescription: json["short_description"],
    description: json["description"],
    whatWillLearn: json["WhatWillLearn"],
    requirements: json["requirements"],
    level: json["level"],
    teachers: List<Teacher>.from(json["teachers"].map((x) => Teacher.fromJson(x))),
    teacher: json["teacher"],
    lessons: List<Lesson>.from(json["lessons"].map((x) => Lesson.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "owner": owner,
    "name": name,
    "slug": slug,
    "category": category,
    "subCategory": subCategory,
    "image": image,
    "discountPrice": discountPrice,
    "price": price,
    "short_description": shortDescription,
    "description": description,
    "teacher": teacher,
    "WhatWillLearn": whatWillLearn,
    "requirements": requirements,
    "level": level,
    "teachers": List<dynamic>.from(teachers.map((x) => x.toJson())),
    "lessons": List<dynamic>.from(lessons.map((x) => x.toJson())),
  };
}

class Lesson {
  Lesson({
    this.key,
    this.name,
  });

  int key;
  dynamic name;

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
    key: json["key"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "name": name,
  };
}

class Teacher {
  Teacher({
    this.key,
    this.name,
    this.country,
    this.qualifications,
    this.whatsApp,
    this.facebook,
    this.image,
  });

  int key;
  String name;
  dynamic country;
  dynamic qualifications;
  dynamic whatsApp;
  dynamic facebook;
  String image;

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
    key: json["key"],
    name: json["name"],
    country: json["country"],
    qualifications: json["qualifications"],
    whatsApp: json["whatsApp"],
    facebook: json["facebook"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "name": name,
    "country": country,
    "qualifications": qualifications,
    "whatsApp": whatsApp,
    "facebook": facebook,
    "image": image,
  };
}
