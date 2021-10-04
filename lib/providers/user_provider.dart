import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/models/user_type_enum.dart';

class UserProvider with ChangeNotifier {
  late UserType _currentUser;

  UserType get currentUser => _currentUser;

  set currentUser(UserType user) => _currentUser = user;
}
