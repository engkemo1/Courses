class CheckResData {
  CheckResData({
    this.tokenExpire,
  });

  bool tokenExpire;

  factory CheckResData.fromJson(Map<String, dynamic> json) => CheckResData(
    tokenExpire:json["token_work"] == null ? null : json["token_work"],
  );

  Map<String, dynamic> toJson() => {
    "token_work":tokenExpire == null ? null : tokenExpire,
  };
}
