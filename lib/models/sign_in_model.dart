class SignInModel {
  String? password;
  String? phone;

  SignInModel({required this.password, this.phone});

  SignInModel.fromJson(Map<String, dynamic> json) {
    //username = json['name'];

    phone = json['phone'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['name'] = this.username;
    data['password'] = this.password;

    data['phone'] = this.phone;
    return data;
  }
}
