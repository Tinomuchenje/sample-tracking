import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';

import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:sample_tracking_system_flutter/utils/dao/samples_dao.dart';
import 'package:sample_tracking_system_flutter/utils/dao/shipment_dao.dart';

import 'package:uuid/uuid.dart';

class ShipmentProvider with ChangeNotifier {
  Uuid uuid = const Uuid();

  final Shipment _shipment = Shipment(samples: []);
  final List<Shipment> _shipments = [];

  Shipment get shipment => _shipment;

  List<Shipment> get shipments {
    getAllShipmentsFromdatabase();
    return [..._shipments];
  }

  Future addShipment(Shipment? shipment) async {
    if (shipment == null) return;

    shipment.id = uuid.v1();
    await saveOrUpdate(shipment);
    notifyListeners();
  }

  Future addShipmentsToSamples(Shipment shipment) async {
    for (var sampleId in shipment.samples) {
      if (sampleId == null) continue;
      Sample sample = await SampleDao().getSample(sampleId);
      sample.shipmentId = shipment.id;
      await SampleDao().insertOrUpdate(sample);
    }
  }

  Future saveOrUpdate(Shipment shipment) async {
    await addShipmentsToSamples(shipment);
    await ShipmentDao().insertOrUpdate(shipment).then((value) {
      _shipments.add(shipment);
      notifyListeners();
    });
  }

  Future getAllShipmentsFromdatabase() async {
    await ShipmentDao().getAllShipments().then((value) {
      _shipments.clear();
      _shipments.addAll(value);
      notifyListeners();
    });
  }

  Future updateShipment(Shipment shipment) async {
    await saveOrUpdate(shipment);
    notifyListeners();
  }

  Future deleteShipment(Shipment shipment) async {
    await ShipmentDao().delete(shipment);
    notifyListeners();
  }
}
