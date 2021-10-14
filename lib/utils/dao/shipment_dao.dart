import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:sembast/sembast.dart';

import '../sembast.dart';

class ShipmentDao {
  static const String tableName = "Shipments";
  final _shipmentTable = stringMapStoreFactory.store(tableName);

  Future<Database> get _database async => AppDatabase.instance.database;

  Future insertShipment(Shipment shipment) async {
    String shipmentId = shipment.id ?? "";
    await _shipmentTable
        .record(shipmentId)
        .put(await _database, shipment.toJson());
  }

  Future insertShipmentAsJson(Map<String, dynamic> value) async {
    await _shipmentTable.add(await _database, value);
  }

  Future insertLabs(List<Map<String, dynamic>> value) async {
    await _shipmentTable.addAll(await _database, value);
  }

  Future update(Shipment shipment) async {
    final finder = Finder(filter: Filter.byKey(shipment.id));
    await _shipmentTable.update(await _database, shipment.toJson(),
        finder: finder);
  }

  Future<Shipment> getShipment(String shipmentId) async {
    var map = await _shipmentTable.record(shipmentId).get(await _database);
    if (map == null) return Shipment(samples: []);
    return Shipment.fromJson(map);
  }

  Future delete(Shipment shipment) async {
    final finder = Finder(filter: Filter.byKey(shipment.id));
    await _shipmentTable.delete(await _database, finder: finder);
  }

  Future<List<Shipment>> getAllShipments() async {
    final recordSnapshot = await _shipmentTable.find(await _database);

    return recordSnapshot.map((snapshot) {
      final shipments = Shipment.fromJson(snapshot.value);
      return shipments;
    }).toList();
  }
}
