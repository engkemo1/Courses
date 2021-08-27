class GetPlacementExamResData {
  int key;
  String title;
  String time;
  String sectionsCount;
  List<Sections> sections;

  GetPlacementExamResData({this.key, this.title, this.time, this.sectionsCount, this.sections});

  GetPlacementExamResData.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    title = json['title'];
    time = json['time'];
    sectionsCount = json['sections_count'];
    if (json['sections'] != null) {
      sections = new List<Sections>();
      json['sections'].forEach((v) {
        sections.add(new Sections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['title'] = this.title;
    data['time'] = this.time;
    data['sections_count'] = this.sectionsCount;
    if (this.sections != null) {
      data['sections'] = this.sections.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sections {
  int key;
  String title;
  List<Questions> questions;

  Sections({this.key, this.title, this.questions});

  Sections.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    title = json['title'];
    if (json['questions'] != null) {
      questions = new List<Questions>();
      json['questions'].forEach((v) {
        questions.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['title'] = this.title;
    if (this.questions != null) {
      data['questions'] = this.questions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  int key;
  String question;
  int correctAnswer;
  List<Answers> answers;

  Questions({this.key, this.question, this.correctAnswer, this.answers});

  Questions.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    question = json['question'];
    correctAnswer = json['correct_answer'];
    if (json['answers'] != null) {
      answers = new List<Answers>();
      json['answers'].forEach((v) {
        answers.add(new Answers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['question'] = this.question;
    data['correct_answer'] = this.correctAnswer;
    if (this.answers != null) {
      data['answers'] = this.answers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answers {
  int key;
  String answer;

  Answers({this.key, this.answer});

  Answers.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['answer'] = this.answer;
    return data;
  }
}