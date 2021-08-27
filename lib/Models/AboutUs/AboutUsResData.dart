class AboutUsResData {
  AboutUsResData({
    this.key,
    this.name,
    this.image,
    this.shDesc,
    this.fullDesc,
  });

  int key;
  String name;
  dynamic image;
  String shDesc;
  String fullDesc;

  factory AboutUsResData.fromJson(Map<String, dynamic> json) => AboutUsResData(
    key:json["key"] == null ? null : json["key"],
    name:json["name"] == null ? null :  json["name"],
    image:json["image"] == null ? null :  json["image"],
    shDesc:json["sh_desc"] == null ? null :  json["sh_desc"],
    fullDesc:json["full_desc"] == null ? null :  json["full_desc"],
  );

  Map<String, dynamic> toJson() => {
    "key":key == null ? null : key,
    "name":name == null ? null :  name,
    "image":image == null ? null :  image,
    "sh_desc":shDesc == null ? null :  shDesc,
    "full_desc":fullDesc == null ? null :  fullDesc,
  };
}
