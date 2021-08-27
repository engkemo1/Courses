class ContactUsResData {
  ContactUsResData({
    this.phone,
    this.email,
    this.address,
    this.location,
  });

  String phone;
  String email;
  String address;
  String location;

  factory ContactUsResData.fromJson(Map<String, dynamic> json) => ContactUsResData(
    phone:json["phone"] == null ? null : json["phone"],
    email:json["email"] == null ? null : json["email"],
    address:json["address"] == null ? null : json["address"],
    location:json["location"] == null ? null : json["location"],
  );

  Map<String, dynamic> toJson() => {
    "phone":phone == null ? null : phone,
    "email":email == null ? null : email,
    "address":address == null ? null : address,
    "location":location == null ? null : location,
  };
}
