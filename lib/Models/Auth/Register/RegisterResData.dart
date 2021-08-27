class RegisterResData {
  RegisterResData({
    this.key,
    this.type,
    this.verified,
    this.name,
  });

  int key;
  String type;
  dynamic verified;
  String name;

  factory RegisterResData.fromJson(Map<String, dynamic> json) => RegisterResData(
    key:json["key"] == null ? null : json["key"],
    type:json["type"] == null ? null : json["type"],
    verified:json["verified"] == null ? null : json["verified"],
    name:json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "key":key == null ? null : key,
    "type":type == null ? null : type,
    "verified":verified == null ? null : verified,
    "name":name == null ? null : name,
  };
}
