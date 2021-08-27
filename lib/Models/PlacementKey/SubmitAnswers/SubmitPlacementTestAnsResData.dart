class SubmitPlacementTestAnsResData {
  int key;
  String title;
  int score;
  int total;
  bool pass;
  int rate;
  List<Sections> sections;

  SubmitPlacementTestAnsResData(
      {this.key,
        this.title,
        this.score,
        this.total,
        this.pass,
        this.rate,
        this.sections});

  SubmitPlacementTestAnsResData.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    title = json['title'];
    score = json['score'];
    total = json['total'];
    pass = json['pass'];
    rate = json['rate'];
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
    data['score'] = this.score;
    data['total'] = this.total;
    data['pass'] = this.pass;
    data['rate'] = this.rate;
    if (this.sections != null) {
      data['sections'] = this.sections.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sections {
  int key;
  String title;
  int score;
  int total;

  Sections({this.key, this.title, this.score, this.total});

  Sections.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    title = json['title'];
    score = json['score'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['title'] = this.title;
    data['score'] = this.score;
    data['total'] = this.total;
    return data;
  }
}