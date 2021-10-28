import 'package:sample_tracking_system_flutter/models/patient.dart';
import 'package:sembast/sembast.dart';
import 'package:uuid/uuid.dart';

import '../sembast.dart';

class PatientDao {
  static const String tableName = "Patients";
  final _patientTable = stringMapStoreFactory.store(tableName);
  Uuid uuid = const Uuid();

  Future<Database> get _database async => AppDatabase.instance.database;

  Future insertOrUpdate(Patient patient) async {
 

    await _patientTable
        .record(patient.appId)
        .put(await _database, patient.toJson());
  }

  Future delete(Patient shipment) async {
    final finder = Finder(filter: Filter.byKey(shipment.id));
    await _patientTable.delete(await _database, finder: finder);
  }

  Future<List<Patient>> getLocalPatients() async {
    final recordSnapshot = await _patientTable.find(await _database);

    return recordSnapshot.map((snapshot) {
      final patients = Patient.fromJson(snapshot.value);
      return patients;
    }).toList();
  }
}
