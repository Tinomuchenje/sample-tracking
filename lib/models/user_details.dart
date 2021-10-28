
class User {
  String? accessId;
  String? accessLevel;
  bool? activated;
  List<String>? authorities;
  String? createdBy;
  String? createdDate;
  String? email;
  String? firstName;
  int? id;
  String? imageUrl;
  String? langKey;
  String? lastModifiedBy;
  String? lastModifiedDate;
  String? lastName;
  String? login;
  String? password;

  User(
      {this.accessId,
        this.accessLevel,
        this.activated,
        this.authorities,
        this.createdBy,
        this.createdDate,
        this.email,
        this.firstName,
        this.id,
        this.imageUrl,
        this.langKey,
        this.lastModifiedBy,
        this.lastModifiedDate,
        this.lastName,
        this.login,
        this.password});

  User.fromJson(Map<String, dynamic> json) {
    accessId = json['accessId'];
    accessLevel = json['accessLevel'];
    activated = json['activated'];
    authorities = json['authorities'].cast<String>();
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    email = json['email'];
    firstName = json['firstName'];
    id = json['id'];
    imageUrl = json['imageUrl'];
    langKey = json['langKey'];
    lastModifiedBy = json['lastModifiedBy'];
    lastModifiedDate = json['lastModifiedDate'];
    lastName = json['lastName'];
    login = json['login'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessId'] = this.accessId;
    data['accessLevel'] = this.accessLevel;
    data['activated'] = this.activated;
    data['authorities'] = this.authorities;
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    data['langKey'] = this.langKey;
    data['lastModifiedBy'] = this.lastModifiedBy;
    data['lastModifiedDate'] = this.lastModifiedDate;
    data['lastName'] = this.lastName;
    data['login'] = this.login;
    data['password'] = this.password;
    return data;
  }
}
