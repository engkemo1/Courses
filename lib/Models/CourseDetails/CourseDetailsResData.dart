class CourseDetailsResData {
  CourseDetailsResData({
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
    this.exam,
    this.placementTest,
    this.teachers,
    this.currentLessonKey,
    this.chapters,
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
  int exam;
  int placementTest;
  List<Teacher> teachers;
  int currentLessonKey;
  List<Chapter> chapters;

  factory CourseDetailsResData.fromJson(Map<String, dynamic> json) => CourseDetailsResData(
    key:json["key"] == null ? null : json["key"],
    owner:json["owner"] == null ? null : json["owner"],
    name:json["name"] == null ? null : json["name"],
    slug:json["slug"] == null ? null : json["slug"],
    category:json["category"] == null ? null : json["category"],
    subCategory:json["subCategory"] == null ? null : json["subCategory"],
    image:json["image"] == null ? null : json["image"],
    discountPrice:json["discountPrice"] == null ? null : json["discountPrice"],
    price:json["price"] == null ? null : json["price"],
    shortDescription:json["short_description"] == null ? null : json["short_description"],
    description:json["description"] == null ? null : json["description"],
    whatWillLearn:json["WhatWillLearn"] == null ? null : json["WhatWillLearn"],
    requirements:json["requirements"] == null ? null : json["requirements"],
    level:json["level"] == null ? null : json["level"],
    exam:json["exam"] == null ? null : json["exam"],
    placementTest:json["placementTest"] == null ? null : json["placementTest"],
    teachers:json["teachers"] == null ? null : List<Teacher>.from(json["teachers"].map((x) => Teacher.fromJson(x))),
    currentLessonKey:json["currentLessonKey"] == null ? null : json["currentLessonKey"],
    chapters:json["chapters"] == null ? null : List<Chapter>.from(json["chapters"].map((x) => Chapter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "key":key == null ? null : key,
    "owner":owner == null ? null : owner,
    "name":name == null ? null : name,
    "slug":slug == null ? null : slug,
    "category":category == null ? null : category,
    "subCategory":subCategory == null ? null : subCategory,
    "image":image == null ? null : image,
    "discountPrice":discountPrice == null ? null : discountPrice,
    "price":price == null ? null : price,
    "short_description":shortDescription == null ? null : shortDescription,
    "description":description == null ? null : description,
    "WhatWillLearn":whatWillLearn == null ? null : whatWillLearn,
    "requirements":requirements == null ? null : requirements,
    "level":level == null ? null : level,
    "exam":exam == null ? null : exam,
    "placementTest":placementTest == null ? null : placementTest,
    "teachers":teachers == null ? null : List<dynamic>.from(teachers.map((x) => x.toJson())),
    "currentLessonKey":currentLessonKey == null ? null : currentLessonKey,
    "chapters":chapters == null ? null : List<dynamic>.from(chapters.map((x) => x.toJson())),
  };
}

class Chapter {
  Chapter({
    this.key,
    this.name,
    this.quiz,
    this.lessonsList,
  });

  int key;
  String name;
  bool quiz;
  List<LessonsList> lessonsList;

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
    key:json["key"] == null ? null : json["key"],
    name:json["name"] == null ? null : json["name"],
    quiz:json["quiz"] == null ? null : json["quiz"],
    lessonsList:json["LessonsList"] == null ? null : List<LessonsList>.from(json["LessonsList"].map((x) => LessonsList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "key":key == null ? null : key,
    "name":name == null ? null : name,
    "quiz":quiz == null ? null : quiz,
    "LessonsList":lessonsList == null ? null : List<dynamic>.from(lessonsList.map((x) => x.toJson())),
  };
}

class LessonsList {
  LessonsList({
    this.key,
    this.name,
  });

  int key;
  String name;

  factory LessonsList.fromJson(Map<String, dynamic> json) => LessonsList(
    key:json["key"] == null ? null : json["key"],
    name:json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "key":key == null ? null : key,
    "name":name == null ? null : name,
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
    key:json["key"] == null ? null : json["key"],
    name:json["name"] == null ? null : json["name"],
    country:json["country"] == null ? null : json["country"],
    qualifications:json["qualifications"] == null ? null : json["qualifications"],
    whatsApp:json["whatsApp"] == null ? null : json["whatsApp"],
    facebook:json["facebook"] == null ? null : json["facebook"],
    image:json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "key":key == null ? null : key,
    "name":name == null ? null : name,
    "country":country == null ? null : country,
    "qualifications":qualifications == null ? null : qualifications,
    "whatsApp":whatsApp == null ? null : whatsApp,
    "facebook":facebook == null ? null : facebook,
    "image":image == null ? null : image,
  };
}
