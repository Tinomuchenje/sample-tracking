import 'dart:convert';

import 'package:sample_tracking_system_flutter/consts/api_urls.dart';
import 'package:sample_tracking_system_flutter/models/user.dart';
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

  static Future<UserDetails> login(AuthenticationUser user) async {
    var userdetails = UserDetails();
    await http
        .post(Uri.parse(loginUrl), headers: headers, body: json.encode(user))
        .then((response) {
      if (response.statusCode != 200) return;
      userdetails = UserDetails.fromJson(jsonDecode(response.body));
    }).catchError((error) {});

    return userdetails;
  }
}
