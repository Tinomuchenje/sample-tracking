import 'package:flutter/cupertino.dart';

class AccessLevels with ChangeNotifier {
  bool _isProvince = false;
  bool _isDistrict = false;
  bool _isClient = false;

  bool get isDistrict => _isDistrict;

  set isDistrict(bool isDistrict) {
    _isDistrict = isDistrict;
    _isClient = _isProvince = false;
    notifyListeners();
  }

  bool get isProvince => _isProvince;

  set isProvince(bool isProvince) {
    _isProvince = isProvince;
    _isClient = _isDistrict = false;
    notifyListeners();
  }

  bool get isClient => _isClient;

  set isClient(bool isClient) {
    _isClient = isClient;
    _isProvince = _isDistrict = false;
    notifyListeners();
  }
}
