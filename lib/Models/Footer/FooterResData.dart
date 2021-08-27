class FooterResData {
  FooterResData({
    this.phone,
    this.email,
    this.address,
    this.location,
    this.whatsapp,
    this.facebook,
    this.twitter,
    this.linkedin,
    this.instagram,
    this.youTube,
  });

  String phone;
  String email;
  String address;
  String location;
  String whatsapp;
  String facebook;
  String twitter;
  String linkedin;
  String instagram;
  String youTube;

  factory FooterResData.fromJson(Map<String, dynamic> json) => FooterResData(
    phone:json["phone"] == null ? null : json["phone"],
    email:json["email"] == null ? null :  json["email"],
    address:json["address"] == null ? null :  json["address"],
    location:json["location"] == null ? null :  json["location"],
    whatsapp:json["whatsapp"] == null ? null :  json["whatsapp"],
    facebook:json["facebook"] == null ? null :  json["facebook"],
    twitter:json["twitter"] == null ? null :  json["twitter"],
    linkedin:json["linkedin"] == null ? null :  json["linkedin"],
    instagram:json["instagram"] == null ? null :  json["instagram"],
    youTube:json["youTube"] == null ? null :  json["youTube"],
  );

  Map<String, dynamic> toJson() => {
    "phone":phone == null ? null : phone,
    "email":email == null ? null :  email,
    "address":address == null ? null :  address,
    "location":location == null ? null :  location,
    "whatsapp":whatsapp == null ? null :  whatsapp,
    "facebook":facebook == null ? null :  facebook,
    "twitter":twitter == null ? null :  twitter,
    "linkedin":linkedin == null ? null :  linkedin,
    "instagram":instagram == null ? null :  instagram,
    "youTube":youTube == null ? null :  youTube,
  };
}
