import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';

import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:sample_tracking_system_flutter/utils/dao/samples_dao.dart';
import 'package:sample_tracking_system_flutter/utils/dao/shipment_dao.dart';
import 'package:sample_tracking_system_flutter/views/sample/sample_controller.dart';

import 'package:uuid/uuid.dart';

class ShipmentProvider with ChangeNotifier {
  Uuid uuid = const Uuid();

  final Shipment _shipment = Shipment(samples: []);
  final List<Shipment> _shipments = [];
  final List<Sample> _shipmentSamples = [];

  Shipment get shipment => _shipment;

  List<Shipment> get shipments {
    getAllShipmentsFromdatabase();
    return [..._shipments];
  }

  List<Shipment> get clientShipments {
    var clientShipments =
        _shipments.where((shipement) => shipement.status == "client");
    return [...clientShipments];
  }

  List<Shipment> get hubShipments {
    var hubShipments =
        _shipments.where((shipement) => shipement.status == "hub");
    return [...hubShipments];
  }

  List<Shipment> get labShipments {
    var labShipments =
        _shipments.where((shipement) => shipement.status == "lab");
    return [...labShipments];
  }

  List<Shipment> get closedShipments {
    var closedShipments =
        _shipments.where((shipement) => shipement.status == "closed");
    return [...closedShipments];
  }

  List<Sample> get shipmentSamples {
    loadSamples();
    return [..._shipmentSamples];
  }

  loadSamples() async {
    await SampleController.getSamplesFromIds(_shipment.samples)
        .then((listOfSamples) {
      _shipmentSamples.clear();
      _shipmentSamples.addAll(listOfSamples);
      notifyListeners();
    }).catchError((error) {
//
    });
  }

  Future<Shipment> addUpdateShipment(Shipment shipment) async {
    setShipmentValues(shipment);
    await addToLocalDatabase(shipment);
    notifyListeners();
    return shipment;
  }
  
  Future<Shipment> addToLocalDatabase(Shipment shipment) async {
    await addShipmentsToSamples(shipment);

    await ShipmentDao().insertOrUpdate(shipment).then((value) {
      _shipments.add(shipment);
      notifyListeners();
    });

    return shipment;
  }

  void setShipmentValues(Shipment shipment) {
    if (shipment.appId.isEmpty) {
      shipment.appId = uuid.v1();
    }

    if (_shipment.status.isEmpty) {
      _shipment.status = "Created";
    }

    if (_shipment.dateCreated.isEmpty) {
      _shipment.dateCreated =
          _shipment.dateModified = DateTime.now().toString();
    }
  }

  Future addShipmentsToSamples(Shipment shipment) async {
    for (var sampleId in shipment.samples) {
      Sample sample = await SampleDao().getSample(sampleId);
      sample.shipmentId = shipment.appId;
      await SampleDao().insertOrUpdate(sample);
    }
  }


  Future getAllShipmentsFromdatabase() async {
    await ShipmentDao().getAllShipments().then((value) {
      _shipments.clear();
      _shipments.addAll(value);
      notifyListeners();
    });
  }

  Future deleteShipment(Shipment shipment) async {
    await ShipmentDao().delete(shipment);
    notifyListeners();
  }
}
