import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:sample_tracking_system_flutter/features/courier/courier_shipment_samples.dart';

import 'custom_card.dart';
import 'custom_sync_status.dart';

class CourierShipment extends StatefulWidget {
  final List<Shipment> shipment;
  const CourierShipment({
    Key? key,
    required this.shipment,
  }) : super(key: key);

  @override
  _CourierShipmentState createState() => _CourierShipmentState();
}

class _CourierShipmentState extends State<CourierShipment> {
  @override
  Widget build(BuildContext context) {
    var shipment = widget.shipment;
    return ListView.builder(
      itemCount: shipment.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomCard(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        CourierShipmentSamples(shipment: shipment[index]),
                    fullscreenDialog: true,
                  ),
                );
              },
              title: Text(shipment[index].description.toString()),
              subtitle: Row(
                children: [const Text("Status:"), Text(shipment[index].status)],
              ),
              leading: const Icon(
                Icons.folder,
                size: 45,
                color: Colors.blue,
              ),
              trailing: CustomSyncStatusIcon(
                positiveStatus: shipment[index].synced,
              ),
            ),
          ),
        );
      },
    );
  }
}
