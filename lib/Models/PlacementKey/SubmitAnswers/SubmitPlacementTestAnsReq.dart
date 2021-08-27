class SubmitPlacementTestAnsReq {
  String section;
  List<PlacementQuestions> questions;

  SubmitPlacementTestAnsReq({this.section, this.questions});

  SubmitPlacementTestAnsReq.fromJson(Map<String, dynamic> json) {
    section = json['section'];
    if (json['questions'] != null) {
      questions = new List<PlacementQuestions>();
      json['questions'].forEach((v) {
        questions.add(new PlacementQuestions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['section'] = this.section;
    if (this.questions != null) {
      data['questions'] = this.questions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlacementQuestions {
  String question;
  String answer;

  PlacementQuestions({this.question, this.answer});

  PlacementQuestions.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['answer'] = this.answer;
    return data;
  }
}