import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/consts/table_names.dart';
import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:sample_tracking_system_flutter/utils/sqlite_db.dart';

class ShipmentProvider with ChangeNotifier {
  final dbHelper = DBHelper.instance;

  final Shipment _shipment = Shipment();
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

  void updateShipment(Shipment? shipment) {}

  getAll() {}

  void removeAll() {
    _shipments.clear();
  }
}
