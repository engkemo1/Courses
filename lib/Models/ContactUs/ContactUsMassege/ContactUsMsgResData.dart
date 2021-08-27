class ContactUsMsgResData {
  ContactUsMsgResData({
    this.key,
    this.name,
    this.email,
    this.phone,
    this.msg,
  });

  int key;
  String name;
  String email;
  String phone;
  String msg;

  factory ContactUsMsgResData.fromJson(Map<String, dynamic> json) => ContactUsMsgResData(
    key:json["key"] == null ? null : json["key"],
    name:json["name"] == null ? null : json["name"],
    email:json["email"] == null ? null : json["email"],
    phone:json["phone"] == null ? null : json["phone"],
    msg:json["msg"] == null ? null : json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "key":key == null ? null : key,
    "name":name == null ? null : name,
    "email":email == null ? null : email,
    "phone":phone == null ? null : phone,
    "msg":msg == null ? null : msg,
  };
}
