import 'dart:convert';

import 'package:sample_tracking_system_flutter/consts/api_urls.dart';
import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:http/http.dart' as http;

class ShipmentController {
  addShipment(Shipment shipment) async {
    final response =
        await http.post(Uri.parse(shipmentUrl), body: shipment.toJson());

    if (response.statusCode == 200) {
      return Shipment.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  updateShipment() {}
}
