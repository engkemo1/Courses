class QuizChapterResultReq{
  int chapter_key;
  String result;

  QuizChapterResultReq({this.chapter_key,this.result});

  QuizChapterResultReq.fromJson(Map<String, dynamic> json) {
    chapter_key = json['chapter_key'];
    result = json["result"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chapter_key'] = this.chapter_key;
    data['result'] = this.result;
    return data;
  }
}