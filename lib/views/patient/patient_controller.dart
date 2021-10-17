import 'dart:convert';

import 'package:sample_tracking_system_flutter/models/patient.dart';
import 'package:sample_tracking_system_flutter/consts/constants.dart';
import 'package:http/http.dart' as http;

class PatientController {
  Future<http.Response> fetchOnlinePatients() {
    return http.get(Uri.parse(base_url + 'patients'));
  }

  Future<http.Response> updateOnlinePatient(Patient patient) {
    return http.put(Uri.parse(base_url + 'patients'), body: patient.toJson());
  }

  Future<Patient?> addOnlinePatient(Patient patient) async {
    final response = await http.post(Uri.parse(base_url + 'patient'),
        body: patient.toJson());

    if (response.statusCode == 200) {
      return Patient.fromJson(jsonDecode(response.body));
    }
    return null;
  }
}
