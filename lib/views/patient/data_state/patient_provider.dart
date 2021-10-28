import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/models/patient.dart';
import 'package:sample_tracking_system_flutter/utils/dao/patient_dao.dart';
import 'package:sample_tracking_system_flutter/utils/date_service.dart';
import 'package:sample_tracking_system_flutter/views/patient/patient_controller.dart';
import 'package:uuid/uuid.dart';

class PatientProvider with ChangeNotifier {
  Uuid uuid = const Uuid();
  final Patient _patient = Patient();
  final List<Patient> _patients = [];

  Patient get patient => _patient;

  List<Patient> get patients {
    _allPatientsFromDatabase();
    return [..._patients];
  }

  Future addPatient(Patient patient) async {
    setValue(patient);
    await PatientController().createOrUpdate(patient).then((savedPatient) {
      _addToLocalDatabase(savedPatient);
    });
  }

  void setValue(Patient patient) {
    if (patient.createdBy.isEmpty) patient.createdBy = 'admin';

    if (patient.lastModifiedBy.isEmpty) patient.lastModifiedBy = 'admin';

    if (patient.client.isEmpty) patient.client = "admin";

    var currentDate = DateService.convertToIsoString(DateTime.now());

    if (patient.createdDate.isEmpty) patient.createdDate = currentDate;

    if (patient.lastModifiedDate.isEmpty) {
      patient.lastModifiedDate = currentDate;
    }
  }

  Future _addToLocalDatabase(Patient patient) async {
    await PatientDao().insertOrUpdate(patient).then((value) {
      _patients.clear();
      notifyListeners();
    }).catchError((onError) {});
  }

  Future<void> _allPatientsFromDatabase() async {
    await PatientDao().getLocalPatients().then((value) {
      _patients.clear();
      _patients.addAll(value);
      notifyListeners();
    });
  }

  updatePatient(Patient patient) async {
    await _addToLocalDatabase(patient);
    notifyListeners();
  }
}
