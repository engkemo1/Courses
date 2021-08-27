class ZoomCredResData {
  ZoomCredResData({
    this.sdkKey,
    this.sdkSecret,
  });

  String sdkKey;
  String sdkSecret;

  factory ZoomCredResData.fromJson(Map<String, dynamic> json) => ZoomCredResData(
    sdkKey:json["sdk_key"] == null ? null : json["sdk_key"],
    sdkSecret:json["sdk_secret"] == null ? null : json["sdk_secret"],
  );

  Map<String, dynamic> toJson() => {
    "sdk_key":sdkKey == null ? null : sdkKey,
    "sdk_secret":sdkSecret == null ? null : sdkSecret,
  };
}
