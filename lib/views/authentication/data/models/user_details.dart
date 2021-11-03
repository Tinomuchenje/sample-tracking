import 'package:sample_tracking_system_flutter/views/authentication/user_types_constants.dart';

class UserDetails {
  int? id;
  String? login;
  late String firstName;
  late String lastName;
  String? password;
  String? email;
  String? imageUrl;
  bool? activated;
  String? langKey;
  String? createdBy;
  String? createdDate;
  String? lastModifiedBy;
  String? lastModifiedDate;
  late List<String> authorities;
  String? accessLevel;
  String? accessId;

  UserDetails(
      {this.id,
      this.login,
      this.firstName = "",
      this.lastName = "",
      this.password,
      this.email,
      this.imageUrl,
      this.activated,
      this.langKey,
      this.createdBy,
      this.createdDate,
      this.lastModifiedBy,
      this.lastModifiedDate,
      required this.authorities,
      this.accessLevel,
      this.accessId});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    imageUrl = json['imageUrl'];
    activated = json['activated'];
    langKey = json['langKey'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    lastModifiedBy = json['lastModifiedBy'];
    lastModifiedDate = json['lastModifiedDate'];
    authorities = json['authorities'].cast<String>();
    accessLevel = json['accessLevel'];
    accessId = json['accessId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['login'] = login;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['password'] = password;
    data['imageUrl'] = imageUrl;
    data['activated'] = activated;
    data['langKey'] = langKey;
    data['createdBy'] = createdBy;
    data['createdDate'] = createdDate;
    data['lastModifiedBy'] = lastModifiedBy;
    data['lastModifiedDate'] = lastModifiedDate;
    data['authorities'] = authorities;
    data['accessLevel'] = accessLevel;
    data['accessId'] = accessId;
    return data;
  }

  bool isCourierOnly(List<String> authorities) {
    return authorities.every((element) => element == courier);
  }

  bool isAdmin(List<String> authorities) {
    return authorities.contains(admin);
  }

  bool isHealthWorker(List<String> authorities) {
    return authorities.contains(healthWorker);
  }

  bool isHub(List<String> authorities) {
    return authorities.contains(hub);
  }
}
