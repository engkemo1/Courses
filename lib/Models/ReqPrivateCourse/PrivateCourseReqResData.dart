class PrivateCourseReqResData {
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
  int userId;
  String updatedAt;
  String createdAt;
  int id;
  User user;

  PrivateCourseReqResData(
      {this.teacherId,
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
        this.userId,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.user});

  PrivateCourseReqResData.fromJson(Map<String, dynamic> json) {
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
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
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
    data['user_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  int id;
  String name;
  String email;
  Null emailVerifiedAt;
  String type;
  String phone;
  Null qualifications;
  Null age;
  Null academicYear;
  Null country;
  Null facebook;
  Null whatsApp;
  Null zoom;
  Null teamLink;
  String video;
  Null hourlyPrice;
  Null paid;
  Null remaining;
  int approved;
  int showHome;
  int classes;
  Null timezone;
  String createdAt;
  String updatedAt;
  String gender;
  Null deletedAt;
  int verified;

  User(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.type,
        this.phone,
        this.qualifications,
        this.age,
        this.academicYear,
        this.country,
        this.facebook,
        this.whatsApp,
        this.zoom,
        this.teamLink,
        this.video,
        this.hourlyPrice,
        this.paid,
        this.remaining,
        this.approved,
        this.showHome,
        this.classes,
        this.timezone,
        this.createdAt,
        this.updatedAt,
        this.gender,
        this.deletedAt,
        this.verified});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    type = json['type'];
    phone = json['phone'];
    qualifications = json['qualifications'];
    age = json['age'];
    academicYear = json['academic_year'];
    country = json['country'];
    facebook = json['facebook'];
    whatsApp = json['whatsApp'];
    zoom = json['zoom'];
    teamLink = json['teamLink'];
    video = json['video'];
    hourlyPrice = json['hourly_price'];
    paid = json['paid'];
    remaining = json['remaining'];
    approved = json['approved'];
    showHome = json['showHome'];
    classes = json['classes'];
    timezone = json['timezone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    gender = json['gender'];
    deletedAt = json['deleted_at'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['type'] = this.type;
    data['phone'] = this.phone;
    data['qualifications'] = this.qualifications;
    data['age'] = this.age;
    data['academic_year'] = this.academicYear;
    data['country'] = this.country;
    data['facebook'] = this.facebook;
    data['whatsApp'] = this.whatsApp;
    data['zoom'] = this.zoom;
    data['teamLink'] = this.teamLink;
    data['video'] = this.video;
    data['hourly_price'] = this.hourlyPrice;
    data['paid'] = this.paid;
    data['remaining'] = this.remaining;
    data['approved'] = this.approved;
    data['showHome'] = this.showHome;
    data['classes'] = this.classes;
    data['timezone'] = this.timezone;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['gender'] = this.gender;
    data['deleted_at'] = this.deletedAt;
    data['verified'] = this.verified;
    return data;
  }
}