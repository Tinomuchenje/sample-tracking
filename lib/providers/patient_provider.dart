import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/models/patient.dart';
import 'package:sample_tracking_system_flutter/utils/dao/patient_dao.dart';

class PatientProvider with ChangeNotifier {
  final Patient _patient = Patient();
  final List<Patient> _patients = [];

  Patient get patient => _patient;

  List<Patient> get patients {
    if (_patients.isEmpty) allPatientsFromdatabase();
    return [..._patients];
  }

  void add(Patient? patient) {
    if (patient == null) return;
    patient.client = "admin";
    patient.dateCreated = patient.dateModified = DateTime.now().toString();
    addToLocalDatabase(patient);
    notifyListeners();
  }

  Future addToLocalDatabase(Patient patient) async {
    await PatientDao().insert(patient).then((value) {
      _patients.add(patient);
      notifyListeners();
    }).catchError((onError) {});
  }

  Future<void> allPatientsFromdatabase() async {
    await PatientDao().getAllPatients().then((value) {
      _patients.clear();
      _patients.addAll(value);
      notifyListeners();
    });
  }

  updatePatient(Patient patient) async {
    await PatientDao().update(patient);
    notifyListeners();
  }
}
