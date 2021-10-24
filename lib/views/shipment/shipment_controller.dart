import 'dart:convert';

import 'package:sample_tracking_system_flutter/consts/api_urls.dart';
import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:http/http.dart' as http;

class ShipmentController {
  Future<Shipment> addOnlineShipment(Shipment shipment) async {
    shipment.synced = true;

    if (shipment.id.isNotEmpty) return updateOnlineShipment(shipment);

    return addNewOnlineShipment(shipment);
  }

  Future<Shipment> addNewOnlineShipment(Shipment shipment) async {
    await http
        .post(Uri.parse(shipmentUrl),
            headers: headers, body: json.encode(shipment.toJson()))
        .then((response) {
      shipment = validateResponse(response, shipment);
    }).catchError((error) {
      shipment.synced = false;
    });
    return shipment;
  }

  Shipment validateResponse(http.Response response, Shipment shipment) {
    if (response.statusCode != 200) {
      shipment.synced = false;
    } else {
      shipment = Shipment.fromJson(jsonDecode(response.body));
    }
    return shipment;
  }

  Future<Shipment> updateOnlineShipment(Shipment shipment) async {
    await http
        .put(Uri.parse(shipmentUrl),
            headers: headers, body: json.encode(shipment.toJson()))
        .then((response) {
      shipment = validateResponse(response, shipment);
    }).catchError((error) {
      shipment.synced = false;
    });

    return shipment;
  }

  Future notifyShipment() async {
    String url =
        ("https://rest.bluedotsms.com/api/SendSMS?api_id=API9147119203&api_password=Nmrlsupp@rt&sms_type=P&encoding=T&sender_id=LabResults&phonenumber=+263775313603&textmessage='Hello Tendai, you have shipments ready to be dispatched.'");
    await http.get(Uri.parse(url)).then((value) => null).catchError((error) {});
  }
}
