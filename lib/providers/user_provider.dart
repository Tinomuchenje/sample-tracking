import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/models/enums/user_type_enum.dart';

class UserProvider with ChangeNotifier {
  late UserType _currentUser;
  late String _loginToken;

  UserType get currentUser => _currentUser;

  set currentUser(UserType user) => _currentUser = user;

  String get logintoken => _loginToken;

  set logintoken(String token) {
    _loginToken = token;
    notifyListeners();
  }
}
