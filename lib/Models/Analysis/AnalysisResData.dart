class AnalysisResData {
  AnalysisResData({
    this.courses,
    this.classes,
    this.strudents,
    this.teachers,
  });

  int courses;
  int classes;
  int strudents;
  int teachers;

  factory AnalysisResData.fromJson(Map<String, dynamic> json) => AnalysisResData(
    courses:json["courses"] == null ? null : json["courses"],
    classes:json["classes"] == null ? null :  json["classes"],
    strudents:json["strudents"] == null ? null :  json["strudents"],
    teachers:json["teachers"] == null ? null :  json["teachers"],
  );

  Map<String, dynamic> toJson() => {
    "courses":courses == null ? null : courses,
    "classes":classes == null ? null :  classes,
    "strudents":strudents == null ? null :  strudents,
    "teachers":teachers == null ? null :  teachers,
  };
}
