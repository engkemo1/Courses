class RegisterReqData{
  String name;
  String email;
  String password;
  String confirmPassword;
  String phone;
  String type;


  RegisterReqData(this.name, this.email, this.password,
      this.confirmPassword, this.phone, this.type);


  RegisterReqData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    confirmPassword = json['password_confirmation'];
    type = json['type'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['password_confirmation'] = this.confirmPassword;
    data['phone'] = this.phone;
    data['type'] = this.type;

    return data;
  }
}