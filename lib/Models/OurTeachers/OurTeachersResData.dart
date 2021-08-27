class OurTeachersResData {
  OurTeachersResData({
    this.key,
    this.name,
    this.image,
    this.courses
  });

  int key;
  String name;
  String image;
  List<Map> courses;

  factory OurTeachersResData.fromJson(Map<String, dynamic> json) => OurTeachersResData(
    key:json["key"] == null ? null : json["key"],
    name: json["name"] == null ? null :  json["name"],
    image: json["image"] == null ? null :  json["image"],
  );

  Map<String, dynamic> toJson() => {
    "key": key == null ? null : key,
    "name": name == null ? null : name,
    "image": image == null ? null : image,
  };
}
