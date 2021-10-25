import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:sample_tracking_system_flutter/utils/date_service.dart';
import 'package:sample_tracking_system_flutter/views/courier/status.dart';
import 'package:sample_tracking_system_flutter/views/sample/sample_controller.dart';
import 'package:sample_tracking_system_flutter/views/shipment/shipment_card.dart';
import 'package:sample_tracking_system_flutter/views/shipment/state/shipment_provider.dart';
import 'package:sample_tracking_system_flutter/views/shipment/state/status.dart';

class CourierShipmentSamples extends StatefulWidget {
  Shipment shipment;
  CourierShipmentSamples({Key? key, required this.shipment}) : super(key: key);

  @override
  _CourierShipmentSamplesState createState() => _CourierShipmentSamplesState();
}

class _CourierShipmentSamplesState extends State<CourierShipmentSamples> {
  @override
  Widget build(BuildContext context) {
    String currentStatus = widget.shipment.status;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Samples on shipment'),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text("$currentStatus Shipment"),
          backgroundColor: Colors.grey,
          onPressed: () {
            if (currentStatus == publishedStatus) {
              currentStatus = accept;
            } else if (currentStatus == accept) {
              currentStatus = enroute;
            } else if (currentStatus == enroute) {
              currentStatus = collected;
            } else if (currentStatus == collected) {
              currentStatus = delivered;
            }

            var shipmenti = widget.shipment;
            shipmenti.riderId = "617564934de5aa0c94839c2c";
            shipmenti.riderName = "Tendai Katsande";
            shipmenti.status = currentStatus;
            shipmenti.lastModifiedBy = shipmenti.riderName;
            shipmenti.dateModified =
                DateService.convertToIsoString(DateTime.now());
            Provider.of<ShipmentProvider>(context, listen: false)
                .addUpdateShipment(widget.shipment);

            Navigator.of(context).pop();
          },
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            shipmentExistingSamplesCards(widget.shipment.samples.toList()),
          ],
        ));
  }

  Widget shipmentExistingSamplesCards(List<String> _displayedSamples) {
    if (_displayedSamples.isEmpty) {
      return const Text("No samples available");
    }

    return FutureBuilder(
      future: SampleController.getSamplesFromIds(_displayedSamples),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          //print('project snapshot data is: ${projectSnap.data}');
          return const Text("Loading");
        }
        var samples = snapshot.data as List<Sample>;

        if (samples.isEmpty) const Center(child: Text("No samples available"));

        return ShipmentSamplesCard(samples: samples);
      },
    );
  }
}
