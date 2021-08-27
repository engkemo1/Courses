class EditStudProfReq{
  String name;
  String email;
  String phone;
  String oldPassword;
  String newPassword;
  String newPasswordConfirm;



  EditStudProfReq(this.name, this.email, this.oldPassword,
      this.newPassword, this.phone,this.newPasswordConfirm);


  EditStudProfReq.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    oldPassword = json['oldPassword'];
    newPassword = json['newPassword'];
    newPasswordConfirm = json['newPassword_confirmation'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['oldPassword'] = this.oldPassword;
    data['newPassword'] = this.newPassword;
    data['phone'] = this.phone;
    data['newPassword_confirmation'] = this.newPasswordConfirm;
    return data;
  }

}