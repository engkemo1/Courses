class MyPrivateClassesResData {
  int key;
  String name;
  String type;
  String teacher;
  int weeks;
  int lessons;
  String lessonTime;

  MyPrivateClassesResData(
      {this.key,
        this.name,
        this.type,
        this.teacher,
        this.weeks,
        this.lessons,
        this.lessonTime});

  MyPrivateClassesResData.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    name = json['name'];
    type = json['type'];
    teacher = json['teacher'];
    weeks = json['weeks'];
    lessons = json['lessons'];
    lessonTime = json['lessonTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['name'] = this.name;
    data['type'] = this.type;
    data['teacher'] = this.teacher;
    data['weeks'] = this.weeks;
    data['lessons'] = this.lessons;
    data['lessonTime'] = this.lessonTime;
    return data;
  }
}
