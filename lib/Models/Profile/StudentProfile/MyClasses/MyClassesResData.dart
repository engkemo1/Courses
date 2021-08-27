class MyClassesResData {
  MyClassesResData({
    this.key,
    this.name,
    this.type,
    this.teachers,
    this.weeks,
    this.lessons,
    this.lessonTime,
  });

  int key;
  String name;
  String type;
  List<Teacher> teachers;
  int weeks;
  int lessons;
  String lessonTime;

  factory MyClassesResData.fromJson(Map<String, dynamic> json) => MyClassesResData(
    key:json["key"] == null ? null : json["key"],
    name:json["name"] == null ? null : json["name"],
    type:json["type"] == null ? null : json["type"],
    teachers:json["teachers"] == null ? null : List<Teacher>.from(json["teachers"].map((x) => Teacher.fromJson(x))),
    weeks:json["weeks"] == null ? null : json["weeks"],
    lessons:json["lessons"] == null ? null : json["lessons"],
    lessonTime:json["lessonTime"] == null ? null : json["lessonTime"],
  );

  Map<String, dynamic> toJson() => {
    "key":key == null ? null : key,
    "name":name == null ? null : name,
    "type":type == null ? null : type,
    "teachers":teachers == null ? null : List<dynamic>.from(teachers.map((x) => x.toJson())),
    "weeks":weeks == null ? null : weeks,
    "lessons":lessons == null ? null : lessons,
    "lessonTime":lessonTime == null ? null : lessonTime,
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
