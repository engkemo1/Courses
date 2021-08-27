class ShowMeetingResData {
  ShowMeetingResData({
    this.meetingId,
    this.nickname,
    this.password,
    this.startTime,
    this.role,
  });

  int meetingId;
  String nickname;
  String password;
  String startTime;
  int role;

  factory ShowMeetingResData.fromJson(Map<String, dynamic> json) => ShowMeetingResData(
    meetingId:json["meetingID"] == null ? null : json["meetingID"],
    nickname:json["nickname"] == null ? null : json["nickname"],
    password:json["password"] == null ? null : json["password"],
    startTime:json["start_time"] == null ? null : json["start_time"],
    role:json["role"] == null ? null : json["role"],
  );

  Map<String, dynamic> toJson() => {
    "meetingID":meetingId == null ? null : meetingId,
    "nickname":nickname == null ? null : nickname,
    "password":password == null ? null : password,
    "start_time":startTime == null ? null : startTime,
    "role":role == null ? null : role,
  };

}
