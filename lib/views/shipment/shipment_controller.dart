import 'dart:convert';

import 'package:sample_tracking_system_flutter/consts/api_urls.dart';
import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:http/http.dart' as http;

class ShipmentController {
  Future<Shipment> addOnlineShipment(Shipment shipment) async {
    Shipment savedShipement = Shipment();
    shipment.synced = true;

    await http
        .post(Uri.parse(shipmentUrl),
            headers: headers, body: json.encode(shipment.toJson()))
        .then((response) {
      if (response.statusCode != 200) {
        shipment.synced = false;
        savedShipement = shipment;
        return;
      }

      savedShipement = Shipment.fromJson(jsonDecode(response.body));
    }).catchError((error) {
      shipment.synced = false;
      savedShipement = shipment;
    });

    return savedShipement;
  }

  updateShipment() {}
}
