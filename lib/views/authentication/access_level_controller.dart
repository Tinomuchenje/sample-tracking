import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sample_tracking_system_flutter/consts/api_urls.dart';
import 'package:sample_tracking_system_flutter/views/authentication/data/models/client_model.dart';
import 'package:sample_tracking_system_flutter/views/authentication/data/models/district_model.dart';
import 'package:sample_tracking_system_flutter/views/authentication/data/models/province_model.dart';

class AccessLevelController {
  static Future<List<Client>> getClients() async {
    List<Client> clients = [];
    await http.get(Uri.parse(getAllClientsUrl)).then((response) {
      if (response.statusCode == 200) {
        var clientsMap = jsonDecode(response.body);
        clientsMap.forEach((value) {
          clients.add(Client.fromJson(value));
        });
      }
    });
    return clients;
  }

  static getDistricts() async {
    List<District> districts = [];
    await http.get(Uri.parse(getAllDistrictsUrl)).then((response) {
      if (response.statusCode == 200) {
        var clientsMap = jsonDecode(response.body);
        clientsMap.forEach((value) {
          districts.add(District.fromJson(value));
        });
      }
    });
    return districts;
  }

  static getProvinces() async{
    List<Province> provinces = [];
    await http.get(Uri.parse(getAllProvincesUrl)).then((response) {
      if (response.statusCode == 200) {
        var clientsMap = jsonDecode(response.body);
        clientsMap.forEach((value) {
          provinces.add(Province.fromJson(value));
        });
      }
    });
    return provinces;
  }
}
