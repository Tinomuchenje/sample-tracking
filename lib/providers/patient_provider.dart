import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/consts/table_names.dart';
import 'package:sample_tracking_system_flutter/models/patient.dart';
import 'package:sample_tracking_system_flutter/utils/sqlite_db.dart';

class PatientProvider with ChangeNotifier {
  final dbHelper = DBHelper.instance;

  final Patient _patient = Patient();
  final List<Patient> _patients = [];

  Patient get patient => _patient;
  List<Patient> get patients => [..._patients];

  void add(Patient? patient) {
    if (patient == null) return;

    _patients.add(patient);
    addToLocalDatabase(patient);
    notifyListeners();
  }

  Future<int> addToLocalDatabase(Patient patient) async {
    var row = patient.toMap();
    row["internetStatus"] = 0; //Flag for no internet

    final id = await dbHelper.insert(tablePatient, row);
    return id;
  }

  void update(Patient? patient) {}
  void removeAll() {
    _patients.clear();
  }
}
