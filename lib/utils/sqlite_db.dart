import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sample_tracking_system_flutter/consts/table_names.dart';
import 'package:sample_tracking_system_flutter/utils/db_models/laboratory_fields.dart';
import 'package:sqflite/sqflite.dart';

import 'db_models/patient_fields.dart';
import 'db_models/sample_fields.dart';
import 'db_models/shipment_fields.dart';

class DBHelper {
  final String textType = "TEXT";
  final String booleanType = "BOOLEAN";
  final String dateType = "DATE";
  final String arrayType = "ARRAY";
  final String primaryKey = "PRIMARY KEY";
  final int dbVersion = 1;
  static Database? _database;
  final internetStatus = 'internetStatus';

  //Singleton for instantiation once
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  Future<Database> get db async => _database ??= await _initiateDatabase();

  Future<Database> _initiateDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase(join(await getDatabasesPath(), 'sample_tracking.db'),
        version: dbVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  void _onCreate(Database db, int version) async {
    await createSampleTable(db);

    await createPatientTable(db);

    await createShipmentTable(db);

    await createLaboratoryTable(db);
  }

  Future<void> createLaboratoryTable(Database db) {
    return db.execute('''
  CREATE table $tableLaboritory 
   ( 
    ${LaboritoryFields.laboratoryId} $textType $primaryKey,
    ${LaboritoryFields.name} $textType,
    ${LaboritoryFields.type} $textType,
    ${LaboritoryFields.code} $textType,
    ${LaboritoryFields.createdby} $textType,
    ${LaboritoryFields.dateCreated} $dateType,
    ${LaboritoryFields.lastModifiedBy} $textType,
    ${LaboritoryFields.lastDateModified} $dateType,
    $internetStatus INT NOT NULL
    )
  ''');
  }

  Future<void> createShipmentTable(Database db) {
    return db.execute('''
   CREATE table $tableShipment (
    ${ShipmentFileds.shipmentId} $textType $primaryKey,
    ${ShipmentFileds.clientId} $textType,
    ${ShipmentFileds.samples} $arrayType,
    ${ShipmentFileds.status} $textType,
    ${ShipmentFileds.dateCreated} $textType,
    ${ShipmentFileds.dateModified} $textType,
    $internetStatus INT NOT NULL
   )
  ''');
  }

  Future<void> createPatientTable(Database db) {
    return db.execute('''
    CREATE table $tablePatient(
      ${PatientFields.patientId} $textType $primaryKey,
      ${PatientFields.firstname} $textType,
      ${PatientFields.lastname} $textType,
      ${PatientFields.gender} $textType,
      ${PatientFields.dob} $dateType,
      ${PatientFields.client} $textType,
      ${PatientFields.clientPatientId} $textType,
      ${PatientFields.cohortNumber} $textType,
      ${PatientFields.dateCreated} $dateType,
      ${PatientFields.dateModified} $dateType,
      $internetStatus INT NOT NULL
      )
    ''');
  }

  Future<void> createSampleTable(Database db) {
    return db.execute('''
      CREATE table $tableSample (
       ${SampleTableFields.sample_request_id} $textType $primaryKey,
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
       ${SampleTableFields.modified_at} $dateType,
       $internetStatus INT NOT NULL
       )
      ''');
  }

  Future<int> insert(String table, Map<String, dynamic> row) async {
    Database db = await instance.db;
    return await db.insert(table, row);
  }

  Future<int> update(dynamic id, String primaryKeyName, String table,
      Map<String, dynamic> row) async {
    Database db = await instance.db;
    return await db
        .update(table, row, where: '$primaryKeyName = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> queryAllRecords(table) async {
    Database db = await instance.db;
    return await db.query('$table');
  }

  void _onUpgrade(Database db, int oldVersion, int version) async {
    print("Database  upgrading: ");
  }
}
