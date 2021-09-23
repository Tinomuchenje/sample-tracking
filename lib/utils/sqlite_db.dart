import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sample_tracking_system_flutter/models/laboritory.dart';
import 'package:sample_tracking_system_flutter/models/patient.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  final String textType = "TEXT";
  final String booleanType = "BOOLEAN";
  final String dateType = "DATE";
  final String arrayType = "ARRAY";
  final String primaryKey = "PRIMARY KEY";
  final int dbVersion = 1;
  static var _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase(join(await getDatabasesPath(), 'sample_tracking.db'),
        version: dbVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute('''
        CREATE table $tableSample (
         ${SampleTableFields.sample_request_id} $textType,
         ${SampleTableFields.client_sample_id} $textType,
         ${SampleTableFields.patient_id} $textType,
         ${SampleTableFields.lab_id} $textType,
         ${SampleTableFields.client_id} $textType,
         ${SampleTableFields.sample_id} $textType,
         ${SampleTableFields.test_id} $textType,
         ${SampleTableFields.date_collected} $dateType,
         ${SampleTableFields.status} $textType,
         ${SampleTableFields.synced} $booleanType,
         ${SampleTableFields.synced_at} $dateType,
         ${SampleTableFields.lab_reference_id} $textType,
         ${SampleTableFields.location} $textType,
         ${SampleTableFields.result} $textType,
         ${SampleTableFields.shipment_id} $textType,
         ${SampleTableFields.client_contact} $textType,
         ${SampleTableFields.created_at} $dateType,
         ${SampleTableFields.modified_at} $dateType
         )
        ''');

    await db.execute('''
      CREATE table $tablePatient(
        ${PatientFields.patient_id} $textType,
        ${PatientFields.firstname} $textType,
        ${PatientFields.lastname} $textType,
        ${PatientFields.gender} $textType,
        ${PatientFields.dob} $dateType,
        ${PatientFields.client} $textType,
        ${PatientFields.client_patient_id} $textType,
        ${PatientFields.cohort_number} $textType,
        ${PatientFields.created_at} $dateType,
        ${PatientFields.modified_at} $dateType
        )
      ''');

    // Run the CREATE shipment table
    await db.execute('''
     CREATE table $tableShipment (
      ${ShipmentFileds.shipment_id} $textType,
      ${ShipmentFileds.client_id} $textType,
      ${ShipmentFileds.samples} $textType,
      ${ShipmentFileds.status} $arrayType,
      ${ShipmentFileds.created_at} $dateType,
      ${ShipmentFileds.modified_at} $dateType
     )
    ''');

    // Run CREATE laboratory table
    await db.execute('''
    CREATE table $tableLaboritory 
     ( 
      ${LaboritoryFields.laboratory_id} $textType $primaryKey,
      ${LaboritoryFields.name} $textType,
      ${LaboritoryFields.type} $textType,
      ${LaboritoryFields.code} $textType,
      ${LaboritoryFields.created_by} $textType,
      ${LaboritoryFields.created_date} $dateType,
      ${LaboritoryFields.last_modified_by} $textType,
      ${LaboritoryFields.last_modified_date} $dateType
      )
    ''');
    print("Created tables");
  }

  void _onUpgrade(Database db, int old_version, int version) async {
    print("Database  upgrading: ");
  }
}
