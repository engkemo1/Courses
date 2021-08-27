class LiveCourseResData {
  LiveCourseResData({
    this.key,
    this.name,
    this.slug,
    this.image,
    this.shortDescription,
    this.price,
    this.level,
    this.discountPrice,
    this.teacher,
    this.teacherImg,
    this.category,
    this.startTime,
  });

  int key;
  dynamic name;
  String slug;
  String image;
  String shortDescription;
  int price;
  String level;
  int discountPrice;
  String teacher;
  String teacherImg;
  String category;
  DateTime startTime;

  factory LiveCourseResData.fromJson(Map<String, dynamic> json) => LiveCourseResData(
    key: json["key"] == null ? null : json["key"],
    name: json["name"] == null ? null :  json["name"],
    slug: json["slug"] == null ? null :  json["slug"],
    image: json["image"] == null ? null :  json["image"],
    shortDescription: json["short_description"] == null ? null :  json["short_description"],
    price: json["price"] == null ? null :  json["price"],
    level: json["level"] == null ? null :  json["level"],
    discountPrice: json["discountPrice"] == null ? null :  json["discountPrice"],
    teacher: json["teacher"] == null ? null :  json["teacher"],
    teacherImg: json["teacher_img"] == null ? null :  json["teacher_img"],
    category: json["category"] == null ? null :  json["category"],
    startTime: json["start_time"] == null ? null :  json["start_time"] == null ? null : DateTime.parse(json["start_time"]),
  );

  Map<String, dynamic> toJson() => {
    "key": key == null ? null : key,
    "name": name == null ? null :  name,
    "slug": slug == null ? null :  slug,
    "image": image == null ? null :  image,
    "short_description": shortDescription == null ? null :  shortDescription,
    "price": price == null ? null :  price,
    "level": level == null ? null :  level,
    "discountPrice": discountPrice == null ? null :  discountPrice,
    "teacher": teacher == null ? null :  teacher,
    "teacher_img": teacherImg == null ? null :  teacherImg,
    "category": category == null ? null :  category,
    "start_time": startTime == null ? null :  startTime == null ? null : "${startTime.year.toString().padLeft(4, '0')}-${startTime.month.toString().padLeft(2, '0')}-${startTime.day.toString().padLeft(2, '0')}",
  };
}
