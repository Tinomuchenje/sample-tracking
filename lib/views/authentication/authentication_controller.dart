import 'dart:convert';

import 'package:sample_tracking_system_flutter/consts/api_urls.dart';
import 'package:sample_tracking_system_flutter/models/user.dart';
import 'package:http/http.dart' as http;

class AuthenticationController {
  static Future<String> getToken(User user) async {
    final headers = {
      "Accept": '*/*',
      "Content-Type": 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImF1dGgiOiJST0xFX0FETUlOLFJPTEVfVVNFUiIsImV4cCI6MTYzNjkyMzE4NH0.s4MqeCCovubFdjcck4Rw1CIBqI3YpKqngilqgyOxhqaNWJSzMC-B84H9zdGC9STKB84vI02cEzNKYmit0EUGQw'
    };

    final response = await http.post(Uri.parse(loginUrl),
        headers: headers, body: json.encode(user));

    if (response.statusCode != 200) return "";

    Map<String, dynamic> tokenMap = jsonDecode(response.body);
    return tokenMap.values.first;
  }
}
