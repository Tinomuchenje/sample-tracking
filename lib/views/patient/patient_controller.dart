import 'dart:convert';

import 'package:sample_tracking_system_flutter/consts/api_urls.dart';
import 'package:sample_tracking_system_flutter/models/patient.dart';
import 'package:http/http.dart' as http;
import 'package:sample_tracking_system_flutter/utils/dao/patient_dao.dart';

class PatientController {
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

  Future addPatientsOnline() async {
    await PatientDao().getLocalPatients().then((patients) async {
      for (Patient patient in patients) {
        await createOrUpdate(patient);
      }
    });
  }

  Future<Patient> createOrUpdate(Patient patient) async {
    patient.sync = true;
    if (patient.id == null) {
      return await _createPatient(patient);
    } else {
      return await _updatePatient(patient);
    }
  }

  Future<Patient> _createPatient(Patient patient) async {
    await http
        .post(Uri.parse(patientsUrl),
            headers: headers, body: json.encode(patient))
        .then((response) {
      patient = _validateResponse(response, patient);
    }).catchError((error) {
      patient.sync = false;
    });
    return patient;
  }

  Patient _validateResponse(http.Response response, Patient patient) {
    if (response.statusCode == 201 || response.statusCode == 200) {
      patient = Patient.fromJson(jsonDecode(response.body));
    } else {
      patient.sync = false;
    }
    return patient;
  }

  Future _updatePatient(Patient patient) async {
    await http
        .put(Uri.parse(patientsUrl + patient.id.toString()),
            headers: headers, body: json.encode(patient))
        .then((response) {
      patient = _validateResponse(response, patient);
    }).catchError((error) {
      patient.sync = false;
    });
    return patient;
  }
}
