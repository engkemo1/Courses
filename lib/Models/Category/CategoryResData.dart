class CategoryResData {
  CategoryResData({
    this.key,
    this.name,
    this.slug,
    this.image,
    this.description,
  });

  int key;
  String name;
  String slug;
  dynamic image;
  String description;

  factory CategoryResData.fromJson(Map<String, dynamic> json) => CategoryResData(
    key: json["key"] == null ? null : json["key"],
    name: json["name"] == null ? null :  json["name"],
    slug: json["slug"] == null ? null :  json["slug"],
    image: json["image"] == null ? null :  json["image"],
    description: json["description"] == null ? null :  json["description"],
  );

  Map<String, dynamic> toJson() => {
    "key": key == null ? null : key,
    "name": name == null ? null :  name,
    "slug": slug == null ? null :  slug,
    "image": image == null ? null :  image,
    "description": description == null ? null :  description,
  };
}
