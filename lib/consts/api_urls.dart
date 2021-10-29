import 'package:sample_tracking_system_flutter/utils/dao/app_information_dao.dart';

const baseUrl = 'http://196.27.127.58:4080/api/';
const headers = {
  'accept': 'application/json',
  'content-type': 'application/json'
};

class Token {
  Future<Map<String, String>> buildHeaders() async {
    String t = await AppInformationDao().getToken();

    final headers = {
      'accept': 'application/json',
      'content-type': 'application/json',
      'Authorization': "Token " + t
    };
    return headers;
  }
}

//Authentication
const loginUrl = baseUrl + 'authenticate';
const getAccountUrl = baseUrl + 'account';

// Patient
const patientsUrl = baseUrl + 'patients/';

// Sample
const sampleUrl = baseUrl + 'samples/';

// Shipment
const shipmentUrl = baseUrl + 'shipments/';
