import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:sembast/sembast.dart';

import '../sembast.dart';

class ShipmentDao {
  static const String tableName = "Shipments";
  final _shipmentTable = stringMapStoreFactory.store(tableName);

  Future<Database> get _database async => AppDatabase.instance.database;

  Future<Shipment> insertOrUpdate(Shipment shipment) async {
    String shipmentId = shipment.appId;
    final savedShipment = await _shipmentTable
        .record(shipmentId)
        .put(await _database, shipment.toJson());
    return Shipment.fromJson(savedShipment);
  }

  Future insertShipmentAsJson(Map<String, dynamic> value) async {
    await _shipmentTable.add(await _database, value);
  }

  Future insertLabs(List<Map<String, dynamic>> value) async {
    await _shipmentTable.addAll(await _database, value);
  }

  Future<Shipment> getShipment(String shipmentId) async {
    var map = await _shipmentTable.record(shipmentId).get(await _database);
    if (map == null) return Shipment(samples: []);
    return Shipment.fromJson(map);
  }

  Future delete(Shipment shipment) async {
    final finder = Finder(filter: Filter.byKey(shipment.appId));
    await _shipmentTable.delete(await _database, finder: finder);
  }

  Future<List<Shipment>> getAllShipments() async {
    final recordSnapshot = await _shipmentTable.find(await _database);

    return recordSnapshot.map((snapshot) {
      // Map<String, dynamic> map = snapshot.value;
      Map<String, dynamic> map = Map<String, dynamic>.from(snapshot.value);

      final shipments = Shipment.fromJson(map);
      return shipments;
    }).toList();
  }
}
