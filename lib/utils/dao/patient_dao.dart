import 'package:sample_tracking_system_flutter/models/patient.dart';
import 'package:sembast/sembast.dart';

import '../sembast.dart';

class PatientDao {
  static const String tableName = "Patients";
  final _patientTable = stringMapStoreFactory.store(tableName);

  Future<Database> get _database async => AppDatabase.instance.database;

  Future insertOrUpdate(Patient patient) async {
    String patientId = patient.appId;

    await _patientTable
        .record(patientId)
        .put(await _database, patient.toJson());
  }

  Future insertPatients(List<Map<String, dynamic>> value) async {
    await _patientTable.addAll(await _database, value);
  }

  Future delete(Patient shipment) async {
    final finder = Finder(filter: Filter.byKey(shipment.id));
    await _patientTable.delete(await _database, finder: finder);
  }

  Future<List<Patient>> getAllPatients() async {
    final recordSnapshot = await _patientTable.find(await _database);

    return recordSnapshot.map((snapshot) {
      final patients = Patient.fromJson(snapshot.value);
      return patients;
    }).toList();
  }
}
