import 'dart:convert';

import 'package:sample_tracking_system_flutter/consts/api_urls.dart';
import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:http/http.dart' as http;
import 'package:sample_tracking_system_flutter/utils/dao/shipment_dao.dart';

class ShipmentController {
  Future getOnlineShipments() async {
    await http.get(Uri.parse(shipmentUrl), headers: headers).then((response) {
      if (response.statusCode == 200) {
        var tokenMaps = jsonDecode(response.body);
        tokenMaps.forEach((value) async {
          Shipment shipment = Shipment.fromJson(value);
          shipment.synced = true;

          await ShipmentDao().insertOrUpdate(shipment);
        });
      }
    });
  }

  Future addShipmentsOnline() async {
    await ShipmentDao().getAllShipments().then((shipments) async {
      for (Shipment shipment in shipments) {
        await createOrUpdate(shipment);
      }
    });
  }

  Future<Shipment> createOrUpdate(Shipment shipment) async {
    shipment.synced = true;

    shipment.samples = json.encode(shipment.samples);

    if (shipment.id == null) {
      return await _createShipment(shipment);
    } else {
      return await _updateShipment(shipment);
    }
  }

  Future<Shipment> _createShipment(Shipment shipment) async {
    await http
        .post(Uri.parse(shipmentUrl),
            headers: headers, body: json.encode(shipment))
        .then((response) {
      shipment = _validateResponse(response, shipment);
    }).catchError((error) {
      shipment.synced = false;
    });
    return shipment;
  }

  Shipment _validateResponse(http.Response response, Shipment shipment) {
    if (response.statusCode == 201 || response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      map['samples'] = jsonDecode(map['samples']);
      shipment = Shipment.fromJson(map);
    } else {
      shipment.synced = false;
    }
    return shipment;
  }

  Future _updateShipment(Shipment shipment) async {
    await http
        .put(Uri.parse(shipmentUrl + shipment.id.toString()),
            headers: headers, body: json.encode(shipment))
        .then((response) {
      shipment = _validateResponse(response, shipment);
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
