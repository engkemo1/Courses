class QuizResultReq{
  int lesson_key;
  // int? chapter_key;
  String result;

  QuizResultReq({this.lesson_key,this.result});

  QuizResultReq.fromJson(Map<String, dynamic> json) {
    lesson_key = json['lesson_key'];
    // chapter_key = json['chapter_key'];
    result = json["result"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lesson_key'] = this.lesson_key;
    // data['chapter_key'] = this.chapter_key;
    data['result'] = this.result;
    return data;
  }
}