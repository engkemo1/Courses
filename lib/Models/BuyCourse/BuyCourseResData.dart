class BuyCourseResData {
  BuyCourseResData({
    this.link,
  });

  String link;

  factory BuyCourseResData.fromJson(Map<String, dynamic> json) => BuyCourseResData(
    link:json["link"] == null ? null : json["link"],
  );

  Map<String, dynamic> toJson() => {
    "link":link == null ? null : link,
  };
}
