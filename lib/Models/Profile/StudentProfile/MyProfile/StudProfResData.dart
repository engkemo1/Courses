class StudProfResData {
  StudProfResData({
    this.key,
    this.name,
    this.image,
    this.type,
    this.email,
    this.phone,
    this.country,
  });

  int key;
  String name;
  String image;
  String type;
  String email;
  String phone;
  dynamic country;

  factory StudProfResData.fromJson(Map<String, dynamic> json) => StudProfResData(
    key:json["key"] == null ? null : json["key"],
    name:json["name"] == null ? null : json["name"],
    image:json["image"] == null ? null : json["image"],
    type:json["type"] == null ? null : json["type"],
    email:json["email"] == null ? null : json["email"],
    phone:json["phone"] == null ? '' : json["phone"],
    country:json["country"] == null ? null : json["country"],
  );

  Map<String, dynamic> toJson() => {
    "key":key == null ? null : key,
    "name":name == null ? null : name,
    "type":type == null ? null : type,
    "image":image == null ? null : image,
    "email":email == null ? null : email,
    "phone":phone == null ? '' : phone,
    "country":country == null ? null : country,
  };
}
