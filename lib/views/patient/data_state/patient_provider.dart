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
    allPatientsFromDatabase();
    return [..._patients];
  }

  Future add(Patient patient) async {
    setValue(patient);
    await PatientController().addOnlinePatient(patient).then((savedPatient) {
      addToLocalDatabase(savedPatient);
    });
  }

  void setValue(Patient patient) {
    patient.createdBy = patient.lastModifiedBy = 'admin';
    if (patient.appId.isEmpty) {
      patient.appId = uuid.v1();
    }

    if (patient.client.isEmpty) {
      patient.client = "admin";
    }

    var currentDate = DateService.convertToIsoString(DateTime.now());

    if (patient.createdDate.isEmpty) {
      patient.createdDate = currentDate;
    }

    if (patient.lastModifiedDate.isEmpty) {
      patient.lastModifiedDate = currentDate;
    }
  }

  Future addToLocalDatabase(Patient patient) async {
    await PatientDao().insertOrUpdate(patient).then((value) {
      _patients.add(patient);
      notifyListeners();
    }).catchError((onError) {});
  }

  Future<void> allPatientsFromDatabase() async {
    await PatientDao().getAllPatients().then((value) {
      _patients.clear();
      _patients.addAll(value);
      notifyListeners();
    });
  }

  updatePatient(Patient patient) async {
    await addToLocalDatabase(patient);
    notifyListeners();
  }
}
