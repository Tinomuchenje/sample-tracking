import 'package:flutter/material.dart';

import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:sample_tracking_system_flutter/utils/dao/shipment_dao.dart';
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

  Future addToLocalDatabase(Shipment shipment) async {
    ShipmentDao().insertShipment(shipment);
  }

  Future allShipmentsFromdatabase() async {
    await ShipmentDao().getAllShipments().then((value) {
      _shipments.clear();
      _shipments.addAll(value);
    });

    notifyListeners();
  }

  Future updateShipment(Shipment shipment) async {
    await ShipmentDao().update(shipment);

    notifyListeners();
  }

  Future deleteShipment(Shipment shipment) async {
    await ShipmentDao().delete(shipment);
    notifyListeners();
  }
}
