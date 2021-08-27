class SliderResData {
  SliderResData({
    this.key,
    this.name,
    this.image,
    this.paragraph,
    this.btnName,
    this.btnUrl,
    this.direction,
  });

  int key;
  String name;
  String image;
  String paragraph;
  String btnName;
  String btnUrl;
  String direction;

  factory SliderResData.fromJson(Map<String, dynamic> json) => SliderResData(
    key: json["key"] == null ? null : json["key"],
    name:json["name"] == null ? null :  json["name"],
    image: json["image"] == null ? null :  json["image"],
    paragraph: json["paragraph"] == null ? null :  json["paragraph"],
    btnName: json["btn_name"] == null ? null :  json["btn_name"],
    btnUrl: json["btn_url"] == null ? null :  json["btn_url"] == null ? null : json["btn_url"],
    direction: json["direction"] == null ? null :  json["direction"],
  );

  Map<String, dynamic> toJson() => {
    "key":key == null ? null : key,
    "name":name == null ? null :  name,
    "image":image == null ? null :  image,
    "paragraph":paragraph == null ? null :  paragraph,
    "btn_name":btnName == null ? null :  btnName,
    "btn_url":btnUrl == null ? null :  btnUrl == null ? null : btnUrl,
    "direction":direction == null ? null :  direction,
  };
}
