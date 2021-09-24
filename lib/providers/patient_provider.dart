import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/models/patient.dart';

class PatientProvider with ChangeNotifier {
  late Patient _patient;
  List<Patient> _patients = [];

  Patient get patient => _patient;
  List<Patient> get patients => [..._patients];

  void add(Patient patient) {
    _patients.add(patient);
    notifyListeners();
  }

  void removeAll() {
    _patients.clear();
  }
}
