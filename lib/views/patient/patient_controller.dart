import 'dart:convert';

import 'package:sample_tracking_system_flutter/consts/api_urls.dart';
import 'package:sample_tracking_system_flutter/models/patient.dart';
import 'package:http/http.dart' as http;
import 'package:sample_tracking_system_flutter/utils/dao/patient_dao.dart';

class PatientController {
  Future<Patient> addOnlinePatient(Patient patient) async {
    Patient savedPatient = Patient();
    patient.sync = true;

    await http
        .post(Uri.parse(patientsUrl),
            headers: headers, body: json.encode(patient))
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

  Future getOnlinePatients() async {
    await http.get(Uri.parse(patientsUrl), headers: headers).then((response) {
      if (response.statusCode == 200) {
        var tokenMaps = jsonDecode(response.body);
        tokenMaps.forEach((value) {
          Patient patient = Patient.fromJson(value);
          patient.sync = true;
          PatientDao().insertOrUpdate(patient);
        });
      }
    });
  }

  void addPatientsOnline() async {
    await PatientDao().getLocalPatients().then((patients) {
      for (Patient patient in patients) {
        createOrUpdate(patient);
      }
    });
  }

  Future createOrUpdate(Patient patient) async {
    patient.sync = true;
    if (patient.id == null) {
      await _createPatient(patient);
    } else {
      await _updatePatient(patient);
    }
  }

  Future _createPatient(Patient patient) async {
    await http
        .post(Uri.parse(patientsUrl),
            headers: headers, body: json.encode(patient))
        .then((response) {
      if (response.statusCode == 201) {
        Map<String, dynamic> tokenMap = jsonDecode(response.body);
      }
    });
  }

  Future _updatePatient(Patient patient) async {
    await http
        .put(Uri.parse(patientsUrl + patient.id.toString()),
            headers: headers, body: json.encode(patient))
        .then((response) {
      if (response.statusCode == 201) {}
    });
  }
}
