import 'dart:convert';

import 'package:sample_tracking_system_flutter/consts/api_urls.dart';
import 'package:sample_tracking_system_flutter/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:sample_tracking_system_flutter/models/user_details.dart';
import 'package:sample_tracking_system_flutter/utils/dao/app_information_dao.dart';

class AuthenticationController {
  Future<Map<String, String>> buildHeader() async {
    String token = await AppInformationDao().getToken();

    return {
      'accept': 'application/json',
      'content-type': 'application/json',
      'Authorization': "Bearer " + token
    };
  }

  static Future<String> getToken(AuthenticationUser user) async {
    final response = await http.post(Uri.parse(loginUrl),
        headers: headers, body: json.encode(user));

    if (response.statusCode != 200) return "";

    Map<String, dynamic> tokenMap = jsonDecode(response.body);
    tokenMap.values.first;

    return await AppInformationDao().saveToken(tokenMap.values.first);
  }

  Future<UserDetails> getAccount() async {
    var headers = await buildHeader();
    late UserDetails userDetails;
    await http.get(Uri.parse(getAccountUrl), headers: headers).then((response) {
      if (response.statusCode == 200) {
        userDetails = UserDetails.fromJson(jsonDecode(response.body));
        AppInformationDao().saveUserDetails(userDetails);
      }
    });

    return userDetails;
  }
}
