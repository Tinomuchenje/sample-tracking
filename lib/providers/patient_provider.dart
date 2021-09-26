import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/consts/table_names.dart';
import 'package:sample_tracking_system_flutter/models/patient.dart';
import 'package:sample_tracking_system_flutter/utils/db_models/patient_fields.dart';
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

  Future<void> allPatientsFromdatabase() async {
    final maps = await dbHelper.queryAllRecords(tablePatient);

    var result = List.generate(maps.length, (index) {
      return Patient(
        patientId: maps[index]['patient_id'],
        firstname: maps[index]['firstname'],
        lastname: maps[index]['lastname'],
        gender: maps[index]['gender'],
        dob: maps[index]['dob'],
        client: maps[index]['client'],
        clientPatientId: maps[index]['client_patient_id'],
        cohortNumber: maps[index]['cohort_number'],
        dateCreated: maps[index]['created_at'],
        dateModified: maps[index]['modified_at'],
      );
    });

    removeAll();
    _patients.addAll(result);
    notifyListeners();
  }

  updatePatient(Patient patient) async {
    var row = patient.toMap();
    row["internetStatus"] = 0; //Flag for no internet

    final id = await dbHelper.update(
        patient.patientId, PatientFields.patient_id, tablePatient, row);

    notifyListeners();
  }

  void removeAll() {
    _patients.clear();
  }
}
