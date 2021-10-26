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
    Shipment shipment = widget.shipment;
    String currentStatus = widget.shipment.status;
    String currentStatusPromt = "";
    List<Map> status_label = [
      {"status": "published", "prompt": "Accept", "action": "accepted"},
      {
        "status": "accepted",
        "prompt": "Proceed to facility",
        "action": "enroute"
      },
      {"status": "enroute", "prompt": "Collect", "action": "collect"},
      {"status": "collected", "prompt": "Deliver", "action": "delivered"}
    ];

    var status = status_label
        .where((_status) =>
            _status['status'].toString() ==
            currentStatus.toString().toLowerCase())
        .toList();
    if (status.isNotEmpty) currentStatusPromt = status[0]['prompt'];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Shipment'),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Info'),
              Tab(text: 'Samples'),
            ],
          ),
        ),
        floatingActionButton: Visibility(
          visible: status.isNotEmpty,
          child: FloatingActionButton.extended(
            label: Text(currentStatusPromt),
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

              shipment.riderId = "617564934de5aa0c94839c2c";
              shipment.riderName = "Tendai Katsande";
              shipment.status = currentStatus;
              shipment.lastModifiedBy = shipment.riderName;
              shipment.dateModified =
                  DateService.convertToIsoString(DateTime.now());
              Provider.of<ShipmentProvider>(context, listen: false)
                  .addUpdateShipment(shipment);

              Navigator.of(context).pop();
            },
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: <Widget>[
                Text(shipment.description),
                Text(shipment.description),
                Text("Number of samples " +
                    shipment.samples.toList().length.toString()),
              ],
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  shipmentExistingSamplesCards(
                      widget.shipment.samples.toList()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
