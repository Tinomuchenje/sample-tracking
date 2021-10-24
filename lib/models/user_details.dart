class UserDetails {
  User? user;
  String token = "";

  UserDetails({this.user, this.token = ""});

  UserDetails.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class User {
  String id = "";
  String firstName = "";
  String lastName = "";
  String gender = "";
  String phone = "";
  String username = "";
  String password = "";
  String role = "";
  String name = "";

  User(
      {this.id = "",
      this.firstName = "",
      this.lastName = "",
      this.gender = "",
      this.phone = "",
      this.username = "",
      this.password = "",
      this.role = "",
      this.name = ""});

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    phone = json['phone'];
    username = json['username'];
    password = json['password'];
    role = json['role'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['gender'] = gender;
    data['phone'] = phone;
    data['username'] = username;
    data['password'] = password;
    data['role'] = role;
    data['name'] = name;
    return data;
  }
}
