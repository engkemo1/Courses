class MessageReq{
  String name;
  String note;

  MessageReq({this.name,this.note});

  MessageReq.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    note = json["note"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['note'] = this.note;
    return data;
  }
}