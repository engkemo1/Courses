class InstData {


  InstData({
    this.key,
    this.name,
    this.image,
    this.country,
    this.qualifications,
    this.whatsApp,
    this.facebook,
  });

  int key;
  String name;
  String image;
  String country;
  String qualifications;
  int whatsApp;
  String facebook;
  List<Map> courses;

  factory InstData.fromJson(Map<String, dynamic> json) =>
      InstData(
        key: json["key"] == null ? null : json["key"],
        name: json["name"] == null ? null : json["name"],
        image: json["image"] == null ? null : json["image"],
        country: json["country"] == null ? null : json["country"],
        qualifications:
            json["qualifications"] == null ? null : json["qualifications"],
        whatsApp: json["whatsApp"] == null ? null : json["whatsApp"],
        facebook: json["facebook"] == null ? null : json["facebook"],
      );

  Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "name": name == null ? null : name,
        "image": image == null ? null : image,
        "country": country == null ? null : country,
        "qualifications": qualifications == null ? null : qualifications,
        "whatsApp": image == null ? null : whatsApp,
        "facebook": image == null ? null : facebook,
      };
}
