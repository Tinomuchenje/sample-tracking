import 'package:flutter/cupertino.dart';
import 'package:sample_tracking_system_flutter/views/authentication/data/client_model.dart';
import 'package:sample_tracking_system_flutter/views/authentication/data/district_model.dart';
import 'package:sample_tracking_system_flutter/views/authentication/data/province_model.dart';

import '../access_level_controller.dart';

class AccessLevel with ChangeNotifier {
  List<Client> _clients = [];
  List<District> _districts = [];
  List<Province> _provinces = [];

  bool _isProvince = false;
  bool _isDistrict = false;
  bool _isClient = false;

  List<Province> get provinces => _provinces;

  set provinces(List<Province> provinces) {
    _provinces = provinces;
    notifyListeners();
  }

  List<District> get districts => _districts;

  set districts(List<District> districts) {
    _districts = districts;
    notifyListeners();
  }

  List<Client> get clients => _clients;

  set clients(List<Client> clients) {
    _clients = clients;
    notifyListeners();
  }

  bool get isDistrict => _isDistrict;

  set isDistrict(bool isDistrict) {
    _isDistrict = isDistrict;
    _isClient = _isProvince = false;
    getDistricts();
    notifyListeners();
  }

  bool get isProvince => _isProvince;

  set isProvince(bool isProvince) {
    _isProvince = isProvince;
    _isClient = _isDistrict = false;
    getProvinces();
    notifyListeners();
  }

  bool get isClient => _isClient;

  set isClient(bool isClient) {
    _isClient = isClient;
    _isProvince = _isDistrict = false;
    getClients();
    notifyListeners();
  }

  Future getClients() async {
    await AccessLevelController.getClients().then((resultClients) {
      clients = resultClients;
      notifyListeners();
    });
  }

  Future getDistricts() async {
    await AccessLevelController.getDistricts().then((resultDistricts) {
      districts = resultDistricts;
      notifyListeners();
    });
  }

  Future getProvinces() async {
    await AccessLevelController.getProvinces().then((resultProvinces) {
      provinces = resultProvinces;
      notifyListeners();
    });
  }
}
