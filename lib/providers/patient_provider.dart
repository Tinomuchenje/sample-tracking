import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/consts/constants.dart';
import 'package:sample_tracking_system_flutter/models/patient.dart';
import 'package:sample_tracking_system_flutter/utils/dao/patient_dao.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;


class PatientProvider with ChangeNotifier {
  Uuid uuid = const Uuid();
  final Patient _patient = Patient();
  final List<Patient> _patients = [];

  Patient get patient => _patient;

  List<Patient> get patients {
    allPatientsFromDatabase();
    return [..._patients];
  }

  void add(Patient? patient) {
    if (patient == null) return;
    patient.appId = uuid.v1();
    patient.client = "admin";
    patient.createdDate = patient.lastModifiedDate = DateTime.now().toString();
    addOnlinePatient(patient);
    addToLocalDatabase(patient);
    notifyListeners();
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

  Future<http.Response> fetchOnlinePatients() {
    return http.get(Uri.parse(base_url+'patients'));
  }

  Future<http.Response> updateOnlinePatient(String id, Patient patient) {
    return http.put(Uri.parse(base_url+'patients'), body: patient.toJson());
  }

  Future<http.Response> addOnlinePatient(Patient patient) {
    return http.post(Uri.parse(base_url+'patients'),body:patient);
  }

}
