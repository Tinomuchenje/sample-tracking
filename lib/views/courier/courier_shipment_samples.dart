import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:sample_tracking_system_flutter/utils/dao/app_information_dao.dart';
import 'package:sample_tracking_system_flutter/utils/date_service.dart';
import 'package:sample_tracking_system_flutter/views/sample/sample_controller.dart';
import 'package:sample_tracking_system_flutter/views/shipment/shipment_card.dart';
import 'package:sample_tracking_system_flutter/views/shipment/state/shipment_provider.dart';

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
      {"status": "accepted", "prompt": "Proceed", "action": "enroute"},
      {"status": "enroute", "prompt": "Collect", "action": "collected"},
      {"status": "collected", "prompt": "Deliver", "action": "delivered"}
    ];

    print(currentStatus);
    var status = status_label
        .where((_status) =>
            _status['status'].toString() ==
            currentStatus.toString().toLowerCase())
        .toList();

    print(status);
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
            onPressed: () async {
              var shipmenti = widget.shipment;
              await AppInformationDao().getUserDetails().then((value) {
                shipmenti.riderId = value!.id.toString();
                shipmenti.riderName = value.firstName + value.lastName;
              });

              shipmenti.status = status[0]['action'];
              shipmenti.lastModifiedBy = shipmenti.riderName;
              shipmenti.dateModified =
                  DateService.convertToIsoString(DateTime.now());
              Provider.of<ShipmentProvider>(context, listen: false)
                  .addUpdateShipment(widget.shipment);

              Navigator.of(context).pop();
            },
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: DataTable(columns: const [
                DataColumn(label: Text("Property")),
                DataColumn(label: Text("Value"))
              ], rows: [
                DataRow(cells: [
                  const DataCell(Text("Description")),
                  DataCell(Text(shipment.description))
                ]),
                DataRow(cells: [
                  const DataCell(Text("Date Created")),
                  DataCell(Text(shipment.dateCreated))
                ]),
                DataRow(cells: [
                  const DataCell(Text("Created by")),
                  DataCell(Text(shipment.createdBy))
                ]),
                DataRow(cells: [
                  const DataCell(Text("Destination")),
                  DataCell(Text(shipment.destination))
                ]),
                DataRow(cells: [
                  const DataCell(Text("Temperature Origin")),
                  DataCell(Text(shipment.temperatureOrigin))
                ]),
                DataRow(cells: [
                  const DataCell(Text("Status")),
                  DataCell(Text(shipment.status))
                ]),
                DataRow(cells: [
                  const DataCell(Text("RiderName")),
                  DataCell(Text(shipment.riderName))
                ]),
              ]),
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
