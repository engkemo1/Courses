class LessonDataResData {
  LessonDataResData({
    this.key,
    this.name,
    this.video,
    this.objective,
    this.material,
    this.summary,
    this.nextLesson,
    this.exam,
    this.nextChapter,
    this.prevTest,
    this.lessonClosed,
    this.endQuizLesson,
  });

  int key;
  String name;
  String video;
  String objective;
  String material;
  String summary;
  int nextLesson;
  bool exam;
  int nextChapter;
  dynamic prevTest;
  bool lessonClosed;
  bool endQuizLesson;

  factory LessonDataResData.fromJson(Map<String, dynamic> json) => LessonDataResData(
    key:json["key"] == null ? null : json["key"],
    name:json["name"] == null ? null : json["name"],
    video:json["video"] == null ? null : json["video"],
    objective:json["objective"] == null ? null : json["objective"],
    material:json["material"] == null ? null : json["material"],
    summary:json["summary"] == null ? null : json["summary"],
    nextLesson:json["nextLesson"] == null ? null : json["nextLesson"],
    exam:json["exam"] == null ? null : json["exam"],
    nextChapter:json["nextChapter"] == null ? null : json["nextChapter"],
    prevTest:json["prevTest"] == null ? null : json["prevTest"],
    lessonClosed:json["lessonClosed"] == null ? null : json["lessonClosed"],
    endQuizLesson:json["endQuizLesson"] == null ? null : json["endQuizLesson"],

  );

  Map<String, dynamic> toJson() => {
    "key":key == null ? null : key,
    "name":name == null ? null : name,
    "video":video == null ? null : video,
    "objective":objective == null ? null : objective,
    "material":material == null ? null : material,
    "summary":summary == null ? null : summary,
    "nextLesson":nextLesson == null ? null : nextLesson,
    "exam":exam == null ? null : exam,
    "nextChapter":nextChapter == null ? null : nextChapter,
    "prevTest":prevTest == null ? null : prevTest,
    "lessonClosed":lessonClosed == null ? null : lessonClosed,
    "endQuizLesson":endQuizLesson == null ? null : endQuizLesson,

  };
}
