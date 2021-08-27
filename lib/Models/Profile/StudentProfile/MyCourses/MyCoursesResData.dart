class MyCoursesResData {
  MyCoursesResData({
    this.key,
    this.name,
    this.slug,
    this.image,
    this.shortDescription,
    this.price,
    this.level,
    this.discountPrice,
    this.teachers,
    this.placement,
    this.finalExam,
    this.teacherImg,
  });

  int key;
  String name;
  String slug;
  String image;
  String shortDescription;
  int price;
  String level;
  int discountPrice;
  List<Teacher> teachers;
  Map<String, dynamic> placement;
  Map<String, dynamic> finalExam;
  String teacherImg;

  factory MyCoursesResData.fromJson(Map<String, dynamic> json) => MyCoursesResData(
    key:json["key"] == null ? null : json["key"],
    name:json["name"] == null ? null : json["name"],
    slug:json["slug"] == null ? null : json["slug"],
    image:json["image"] == null ? null : json["image"],
    shortDescription:json["short_description"] == null ? null : json["short_description"],
    price:json["price"] == null ? null : json["price"],
    level:json["level"] == null ? null : json["level"],
    discountPrice:json["discountPrice"] == null ? null : json["discountPrice"],
    teachers:json["teachers"] == null ? null : List<Teacher>.from(json["teachers"].map((x) => Teacher.fromJson(x))),
    placement:json["placement"] == null ? null : json["placement"],
    finalExam:json["exam"] == null ? null : json["exam"],
    teacherImg:json["teacher_img"] == null ? null : json["teacher_img"],
  );

  Map<String, dynamic> toJson() => {
    "key":key == null ? null : key,
    "name":name == null ? null : name,
    "slug":slug == null ? null : slug,
    "image":image == null ? null : image,
    "short_description":shortDescription == null ? null : shortDescription,
    "price":price == null ? null : price,
    "level":level == null ? null : level,
    "discountPrice":discountPrice == null ? null : discountPrice,
    "teachers":teachers == null ? null : List<dynamic>.from(teachers.map((x) => x.toJson())),
    "placement":placement == null ? null : placement,
    "exam":finalExam == null ? null : finalExam,
    "teacher_img":teacherImg == null ? null : teacherImg,
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
