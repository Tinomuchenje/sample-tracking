import 'dart:convert';

import 'package:sample_tracking_system_flutter/consts/api_urls.dart';
import 'package:sample_tracking_system_flutter/models/patient.dart';
import 'package:http/http.dart' as http;

class PatientController {
  Future<http.Response> fetchOnlinePatients() {
    return http.get(Uri.parse(patientsUrl));
  }

  Future<http.Response> updateOnlinePatient(Patient patient) {
    return http.put(Uri.parse(patientsUrl), body: patient.toJson());
  }

  Future<Patient> addOnlinePatient(Patient patient) async {
    Patient savedPatient = Patient();
    patient.sync = true;

    await http
        .post(Uri.parse(patientsUrl),
            headers: headers, body: json.encode(patient.toJson()))
        .then((response) {
      if (response.statusCode != 200) {
        patient.sync = false;
        savedPatient = patient;
        return;
      }

      savedPatient = Patient.fromJson(jsonDecode(response.body));
    }).catchError((error) {
      patient.sync = false;
      savedPatient = patient;
    });

    return savedPatient;
  }
}
