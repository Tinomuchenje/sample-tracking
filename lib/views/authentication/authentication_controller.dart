import 'dart:convert';

import 'package:sample_tracking_system_flutter/consts/api_urls.dart';
import 'package:sample_tracking_system_flutter/models/auth_user.dart';
import 'package:http/http.dart' as http;
import 'package:sample_tracking_system_flutter/models/user_details.dart';

class AuthenticationController {
  static Future<String> getToken(AuthenticationUser user) async {
    final response = await http.post(Uri.parse(loginUrl),
        headers: headers, body: json.encode(user));

    if (response.statusCode != 200) return "";

    Map<String, dynamic> tokenMap = jsonDecode(response.body);
    return tokenMap.values.first;
  }

  static Future<User> getAccount() async {
    var user;
    await http.post(Uri.parse(accountUrl), headers: headers).then((response) {
      if (response.statusCode != 200) return;

      user = json.decode(response.body);
      print(user);
    }).catchError((error) {
      print(error);
    });
    return user;
  }

  static Future<String> login(AuthenticationUser user) async {
    String token = "";
    await http
        .post(Uri.parse(loginUrl), headers: headers, body: json.encode(user))
        .then((response) {
      if (response.statusCode != 200) return;
      token = (json.decode(response.body))['id_token'];
    }).catchError((error) {});
    return token;
  }
}
