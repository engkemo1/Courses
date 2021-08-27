class QuizResultResData {
  QuizResultResData({
    this.nextLesson,
    this.course,
    this.pass,
  });

  int nextLesson;
  int course;
  String pass;

  factory QuizResultResData.fromJson(Map<String, dynamic> json) => QuizResultResData(
    nextLesson:json["nextLesson"] == null ? null : json["nextLesson"],
    course:json["course"] == null ? null : json["course"],
    pass:json["pass"] == null ? null : json["pass"],
  );

  Map<String, dynamic> toJson() => {
    "nextLesson":nextLesson == null ? null : nextLesson,
    "course":course == null ? null : course,
    "pass":pass == null ? null : pass,
  };
}
