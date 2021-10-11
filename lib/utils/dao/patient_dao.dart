import 'package:sample_tracking_system_flutter/models/patient.dart';
import 'package:sembast/sembast.dart';

import '../sembast.dart';

class PatientDao {
  static const String tableName = "Patients";
  final _patientTable = intMapStoreFactory.store(tableName);

  Future<Database> get _database async => AppDatabase.instance.database;

  Future insert(Patient patient) async {
    await _patientTable.add(await _database, patient.toJson());
  }

  Future insertAsJson(Map<String, dynamic> value) async {
    await _patientTable.add(await _database, value);
  }

  Future insertPatients(List<Map<String, dynamic>> value) async {
    await _patientTable.addAll(await _database, value);
  }

  Future update(Patient patient) async {
    final finder = Finder(filter: Filter.byKey(patient.id));
    await _patientTable.update(await _database, patient.toJson(),
        finder: finder);
  }

  Future delete(Patient shipment) async {
    final finder = Finder(filter: Filter.byKey(shipment.id));
    await _patientTable.delete(await _database, finder: finder);
  }

  Future<List<Patient>> getAllShipments() async {
    final recordSnapshot = await _patientTable.find(await _database);

    return recordSnapshot.map((snapshot) {
      final patients = Patient.fromJson(snapshot.value);
      return patients;
    }).toList();
  }
}
