import 'package:flutter_test/flutter_test.dart';
import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:sample_tracking_system_flutter/providers/shipment_provider.dart';

void main() {
  group("Samples", () {
    final shipmentProvider = ShipmentProvider();
    var shipmentOne = Shipment(
        Id: "1",
        clientId: "1",
        status: "Received",
        dateCreated: DateTime.now().toString(),
        dateModified: DateTime.now().toString());

    var shipmentTwo = Shipment(
        Id: "2",
        clientId: "2",
        status: "Rejected",
        dateCreated: DateTime.now().toString(),
        dateModified: DateTime.now().toString());

    test("Add new shipment", () {
      // Arrange

      // Act
      shipmentProvider.addShipment(shipmentOne);

      // Asssert
      assert(shipmentProvider.shipments[0].Id == shipmentOne.Id);
    });

    test("Add shipment Create shipments Length match samples", () {
      // Arrange

      // Act
      shipmentProvider.addShipment(shipmentOne);
      shipmentProvider.addShipment(shipmentTwo);

      // Assert
      assert(shipmentProvider.shipments.length == 2);
    });

    test("Adding a valid shipment When there is an exisiting one No Duplicates",
        () {
      // Arrange

      // Act
      shipmentProvider.addShipment(shipmentOne);
      shipmentProvider.addShipment(shipmentTwo);

      // Assert
      assert(
          shipmentProvider.shipments[0].Id != shipmentProvider.shipments[1].Id);
    });
  });
}
