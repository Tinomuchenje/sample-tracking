import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/consts/table_names.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:sample_tracking_system_flutter/utils/db_models/shipment_fields.dart';
import 'package:sample_tracking_system_flutter/utils/sqlite_db.dart';

class ShipmentProvider with ChangeNotifier {
  final dbHelper = DBHelper.instance;

  final Shipment _shipment = Shipment(samples: []);
  final List<Shipment> _shipments = [];

  Shipment get shipment => _shipment;

  List<Shipment> get shipments {
    return [..._shipments];
  }

  void addShipment(Shipment? shipment) {
    if (shipment == null) return;

    _shipments.add(shipment);
    addToLocalDatabase(shipment);

    notifyListeners();
  }

  Future<int> addToLocalDatabase(Shipment shipment) async {
    var row = shipment.toMap();
    row["internetStatus"] = 0; //Flag for no internet

    final id = await dbHelper.insert(tableShipment, row);
    return id;
  }

  Future<void> allShipmentsFromdatabase() async {
    final maps = await dbHelper.queryAllRecords(tableShipment);

    var result = List.generate(maps.length, (index) {
      return Shipment(
          id: maps[index]['shipment_id'],
          clientId: maps[index]['client_id'],
          samples: convertToList(maps[index]['samples']),
          status: maps[index]['status'],
          dateCreated: maps[index]['created_at'],
          dateModified: maps[index]['modified_at']);
    });

    removeAll();
    _shipments.addAll(result);
    notifyListeners();
  }

  convertToList(value) {
    var samplesMap = value;
    var xxx = List.generate(samplesMap.length, (index) {
      return Sample(
          sampleRequestId: samplesMap[index]['sample_request_id'],
          clientSampleId: samplesMap[index]['client_sample_id'],
          patientId: samplesMap[index]['patient_id'],
          labId: samplesMap[index]['lab_id'],
          clientId: samplesMap[index]['client_id'],
          sampleId: samplesMap[index]['sample_id'],
          testId: samplesMap[index]['test_id'],
          dateCollected: samplesMap[index]['date_collected'],
          status: samplesMap[index]['status'],
          synced: samplesMap[index]['synced'] == 1 ? true : false,
          dateSynced: samplesMap[index]['synced_at'],
          labReferenceId: samplesMap[index]['lab_reference_id'],
          location: samplesMap[index]['location'],
          result: samplesMap[index]['result'],
          shipmentId: samplesMap[index]['shipment_id'],
          clientContact: samplesMap[index]['client_contact'],
          dateCreated: samplesMap[index]['created_at'],
          dateModified: samplesMap[index]['modified_at']);
    });

    return xxx;
  }

  void updateShipment(Shipment shipment) async {
    var row = shipment.toMap();
    row["internetStatus"] = 0; //Flag for no internet

    final id = await dbHelper.update(
        shipment.id, ShipmentFileds.shipmentId, tableShipment, row);

    notifyListeners();
  }

  getAll() {}

  void removeAll() {
    _shipments.clear();
  }
}
