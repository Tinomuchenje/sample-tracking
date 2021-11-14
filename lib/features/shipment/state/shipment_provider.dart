import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/features/sample/state/samples_provider.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';

import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:sample_tracking_system_flutter/utils/dao/samples_dao.dart';
import 'package:sample_tracking_system_flutter/utils/dao/shipment_dao.dart';
import 'package:sample_tracking_system_flutter/utils/date_service.dart';
import 'package:sample_tracking_system_flutter/features/shipment/state/shipment_status.dart';
import 'package:sample_tracking_system_flutter/features/shipment/shipment_controller.dart';

import 'package:uuid/uuid.dart';

class ShipmentProvider with ChangeNotifier {
  Uuid uuid = const Uuid();

  Shipment _shipment = Shipment(samples: []);
  final List<Shipment> _shipments = [];
  List<Sample> _displayShipmentSamples = [];

  Shipment get shipment => _shipment;

  set shipment(Shipment shipment) {
    _shipment = shipment;
    notifyListeners();
  }

  List<Shipment> get shipments {
    getAllShipmentsFromdatabase();
    return [..._shipments];
  }

  List<Shipment> get clientShipments {
    var clientShipments = _shipments.where((shipement) =>
        shipement.status == createdStatus ||
        shipement.status == publishedStatus);
    return [...clientShipments];
  }

///// Courier shipments
  ///
  ///
  ///
  List<Shipment> get publishedShipments {
    if (_shipments.isEmpty) {
      shipments;
    }
    var publishedShipments =
        _shipments.where((shipment) => shipment.status == publishedStatus);
    return [...publishedShipments];
  }

  List<Shipment> get inprogressShipments {
    if (_shipments.isEmpty) {
      shipments;
    }
    var inprogressShipments = _shipments.where((shipment) =>
        shipment.status == accept ||
        shipment.status == enroute ||
        shipment.status == collected);
    return [...inprogressShipments];
  }

  List<Shipment> get closedShipments {
    if (_shipments.isEmpty) {
      shipments;
    }
    var closedShipments =
        _shipments.where((shipment) => shipment.status == delivered);
    return [...closedShipments];
  }

///////
  ///
  ///

  List<Shipment> get hubShipments {
    var hubShipments = _shipments.where((shipment) => shipment.status == "hub");
    return [...hubShipments];
  }

  List<Shipment> get labShipments {
    var labShipments =
        _shipments.where((shipement) => shipement.status == "lab");
    return [...labShipments];
  }

  List<Sample> get displayShipmentSamples {
    return [..._displayShipmentSamples];
  }

  set displayShipmentSamples(List<Sample> shipmentSamples) {
    _displayShipmentSamples = [...shipmentSamples];
    notifyListeners();
  }

  removeSampleFromDisplayShipment(Sample sample) {
    _displayShipmentSamples.remove(sample);

    List<String> sampleIds = [];

    for (Sample sample in _displayShipmentSamples) {
      sampleIds.add(sample.appId);
    }

    _shipment.samples = sampleIds;

    notifyListeners();
  }

  Future addUpdateShipment(Shipment shipment) async {
    setShipmentValues(shipment);

    await setSampleShipmentDetails(shipment);

    await ShipmentController().createOrUpdate(shipment).then((savedShipment) {
      addToLocalDatabase(savedShipment);
    });
  }

  Future<Shipment> addToLocalDatabase(Shipment shipment) async {
    await ShipmentDao().insertOrUpdate(shipment).then((value) {
      _shipments.clear();
      notifyListeners();
    });

    return shipment;
  }

  void setShipmentValues(Shipment shipment) {
    if (shipment.appId.isEmpty) {
      shipment.appId = uuid.v1();
    }

    if (shipment.dateCreated.isEmpty) {
      shipment.dateCreated = shipment.dateModified =
          DateService.convertToIsoString(DateTime.now());
    }
  }

  Future setSampleShipmentDetails(Shipment shipment) async {
    for (var sampleId in shipment.samples) {
      Sample sample = await SampleDao().getSample(sampleId);
      assignSampleToShipment(sample, shipment);
      sample.location = shipment.destination;
      sample.status = shipment.status;
      await SampleDao().insertOrUpdate(sample);
    }
  }

  void assignSampleToShipment(Sample sample, Shipment shipment) {
    if (sample.shipmentId.isEmpty) {
      sample.shipmentId = shipment.appId.toString();
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
