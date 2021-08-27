class PrivateCourseReq{
  int teacherId;
  int courseId;
  String startDate;
  String note;
  String sat;
  String sun;
  String mon;
  String tue;
  String wed;
  String thu;
  String fri;


  PrivateCourseReq({
        this.teacherId,
        this.courseId,
        this.startDate,
        this.note,
        this.sat,
        this.sun,
        this.mon,
        this.tue,
        this.wed,
        this.thu,
        this.fri,
      });


  PrivateCourseReq.fromJson(Map<String, dynamic> json) {
    teacherId = json['teacher_id'];
    courseId = json['course_id'];
    startDate = json['start_date'];
    note = json['note'];
    sat = json['sat'];
    sun = json['sun'];
    mon = json['mon'];
    tue = json['tue'];
    wed = json['wed'];
    thu = json['thu'];
    fri = json['fri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['teacher_id'] = this.teacherId;
    data['course_id'] = this.courseId;
    data['start_date'] = this.startDate;
    data['note'] = this.note;
    data['sat'] = this.sat;
    data['sun'] = this.sun;
    data['mon'] = this.mon;
    data['tue'] = this.tue;
    data['wed'] = this.wed;
    data['thu'] = this.thu;
    data['fri'] = this.fri;
    return data;
  }
}