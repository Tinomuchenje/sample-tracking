// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sample_tracking_system_flutter/features/authentication/data/user_provider.dart';
import 'package:sample_tracking_system_flutter/features/sample/sample_controller.dart';
import 'package:sample_tracking_system_flutter/features/shipment/shipment_card.dart';
import 'package:sample_tracking_system_flutter/features/shipment/state/shipment_provider.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:sample_tracking_system_flutter/utils/dao/app_information_dao.dart';
import 'package:sample_tracking_system_flutter/utils/date_service.dart';

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
    List<Map> statusLabel = [
      {"status": "published", "prompt": "Accept", "action": "accepted"},
      {"status": "accepted", "prompt": "Proceed", "action": "enroute"},
      {"status": "enroute", "prompt": "Collect", "action": "collected"},
      {"status": "collected", "prompt": "Deliver", "action": "delivered"}
    ];

    var status = statusLabel
        .where((_status) =>
            _status['status'].toString() ==
            currentStatus.toString().toLowerCase())
        .toList();

    if (status.isNotEmpty) currentStatusPromt = status[0]['prompt'];

    //UserDetails? userDetails = Provider.of<UserProvider>(context).userDetails;

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
        floatingActionButton: Consumer<UserProvider>(
            builder: (context, userDetailsProvider, child) {
          var userDetails = userDetailsProvider.userDetails;

          return Visibility(
            visible: status.isNotEmpty &&
                (userDetails != null &&
                    userDetails.isCourierOnly(userDetails.authorities)),
            child: FloatingActionButton.extended(
              label: Text(currentStatusPromt),
              backgroundColor: Colors.grey,
              onPressed: () async {
                var shipmenti = widget.shipment;

                await AppInformationDao().getUserDetails().then((userDetails) {
                  shipmenti.riderId = userDetails!.id.toString();
                  var lastname = userDetails.lastName ?? "";
                  shipmenti.riderName =
                      (userDetails.firstName ?? "" + lastname);
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
          );
        }),
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
                  shipmentExistingSamplesCards(widget.shipment.samples),
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
