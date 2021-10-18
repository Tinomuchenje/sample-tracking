import 'dart:convert';

import 'package:sample_tracking_system_flutter/consts/api_urls.dart';
import 'package:sample_tracking_system_flutter/models/patient.dart';
import 'package:http/http.dart' as http;

class PatientController {
  Future<http.Response> fetchOnlinePatients() {
    return http.get(Uri.parse(baseUrl + 'patients'));
  }

  Future<http.Response> updateOnlinePatient(Patient patient) {
    return http.put(Uri.parse(baseUrl + 'patients'), body: patient.toJson());
  }

  Future<Patient?> addOnlinePatient(Patient patient) async {
    final response = await http.post(Uri.parse(baseUrl + 'patient'),
        body: patient.toJson());

    if (response.statusCode == 200) {
      return Patient.fromJson(jsonDecode(response.body));
    }
    return null;
  }
}
