class LoginResDataFalse {
  LoginResDataFalse({
    this.userKey,
  });

  int userKey;

  factory LoginResDataFalse.fromJson(Map<String, dynamic> json) => LoginResDataFalse(
    userKey:json["user_key"] == null ? null : json["user_key"],
  );

  Map<String, dynamic> toJson() => {
    "user_key":userKey == null ? null : userKey,
  };
}
