class AuthenticationUser {
  late String password;
  late bool rememberMe;
  late String username;

  AuthenticationUser({this.password="", this.rememberMe=false, this.username=""});

  AuthenticationUser.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    rememberMe = json['rememberMe'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['password'] = password;
    data['rememberMe'] = rememberMe.toString();
    data['username'] = username;
    return data;
  }
}
