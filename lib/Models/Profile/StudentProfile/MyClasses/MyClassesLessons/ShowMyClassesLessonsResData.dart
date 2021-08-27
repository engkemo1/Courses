class ShowMyClassesResData {
  ShowMyClassesResData({
    this.key,
    this.name,
    this.day,
    this.date,
    this.time,
    this.status,
    this.meeting,
  });

  int key;
  String name;
  String day;
  String date;
  String time;
  String status;
  bool meeting;

  factory ShowMyClassesResData.fromJson(Map<String, dynamic> json) => ShowMyClassesResData(
    key:json["key"] == null ? null : json["key"],
    name: json["name"] == null ? null : json["name"],
    day:json["day"] == null ? null : json["day"],
    date:json["date"] == null ? null : json["date"],
    time:json["time"] == null ? null : json["time"],
    status:json["status"] == null ? null : json["status"],
    meeting:json["meeting"] == null ? null : json["meeting"],
  );

  Map<String, dynamic> toJson() => {
    "key":key == null ? null : key,
    "name":name == null ? null : name == null ? null : name,
    "day":day == null ? null : day,
    "date":date == null ? null : date,
    "time":time == null ? null : time,
    "status":status == null ? null : status,
    "meeting":meeting == null ? null : meeting,
  };
}
