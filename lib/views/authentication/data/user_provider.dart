import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/utils/dao/app_information_dao.dart';

import 'models/user_details.dart';

class UserProvider with ChangeNotifier {
  UserDetails? _userDetails;

  late String _loginToken;

  UserDetails? get userDetails {
    _getUserDetails();
    return _userDetails;
  }

  set userDetails(UserDetails? userDetails) {
    _userDetails = userDetails;
    notifyListeners();
  }

  Future _getUserDetails() async {
    await AppInformationDao().getUserDetails().then((result) {
      userDetails = result;
    });
  }

  String get logintoken => _loginToken;

  set logintoken(String token) {
    _loginToken = token;
    notifyListeners();
  }
}
