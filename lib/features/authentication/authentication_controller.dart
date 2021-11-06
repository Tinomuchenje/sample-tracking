import 'dart:convert';

import 'package:sample_tracking_system_flutter/consts/api_urls.dart';
import 'package:sample_tracking_system_flutter/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:sample_tracking_system_flutter/utils/date_service.dart';
import 'package:sample_tracking_system_flutter/features/authentication/data/models/user_details.dart';
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

  Future<bool> registerAccount(UserDetails userDetails) async {
    userDetails.createdDate = userDetails.lastModifiedDate =
        DateService.convertToIsoString(DateTime.now());
    userDetails.createdBy = userDetails.lastModifiedBy = userDetails.login;
    userDetails.imageUrl = '';
    userDetails.activated = true;
    userDetails.langKey = 'en';

    var headers = await buildHeader();

    return await http
        .post(Uri.parse(registerAccountUrl),
            headers: headers, body: json.encode(userDetails))
        .then((response) {
      return response.statusCode == 201 || response.statusCode == 200;
    });
  }
}
