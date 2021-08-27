class QuizLessonResData {
  QuizLessonResData({
    this.key,
    this.quistion,
    this.correctAnswer,
    this.answers,
  });

  int key;
  String quistion;
  int correctAnswer;
  List<Answer> answers;

  factory QuizLessonResData.fromJson(Map<String, dynamic> json) => QuizLessonResData(
    key:json["key"] == null ? null : json["key"],
    quistion:json["question"] == null ? null : json["question"],
    correctAnswer:json["correct_answer"] == null ? null : json["correct_answer"],
    answers:json["answers"] == null ? null : List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "key":key == null ? null : key,
    "question":quistion == null ? null : quistion,
    "correct_answer":correctAnswer == null ? null : correctAnswer,
    "answers":answers == null ? null : List<dynamic>.from(answers.map((x) => x.toJson())),
  };
}

class Answer {
  Answer({
    this.key,
    this.answer,
  });

  int key;
  String answer;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
    key:json["key"] == null ? null : json["key"],
    answer:["answer"] == null ? null : json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "key":key == null ? null : key,
    "answer":answer ==null ? null : answer,
  };
}
