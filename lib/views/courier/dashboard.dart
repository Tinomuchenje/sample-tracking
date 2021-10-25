import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:sample_tracking_system_flutter/views/shipment/state/shipment_provider.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_app_drawer.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_card.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_sync_status.dart';

import 'courier_shipment_samples.dart';

class CourierDashboard extends StatefulWidget {
  const CourierDashboard({Key? key}) : super(key: key);

  @override
  _CourierDashboardState createState() => _CourierDashboardState();
}

class _CourierDashboardState extends State<CourierDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
            backgroundColor: Colors.blueGrey[50],
            drawer: const CustomAppDrawer(),
            appBar: AppBar(
              title: const Text("Shipments"),
              // backgroundColor: Colors.lightBlue[900],
              bottom: const TabBar(
                tabs: [
                  Tab(
                    text: ("New"),
                  ),
                  Tab(
                    text: ("In progress"),
                  ),
                  Tab(
                    text: ("Closed"),
                  )
                ],
              ),
            ),
            body: Consumer<ShipmentProvider>(
              builder: (context, shipmentProvider, child) {
                return TabBarView(children: [
                  _shipments(shipmentProvider.publishedShipments),
                  _shipments(shipmentProvider.inprogressShipments),
                  _shipments(shipmentProvider.closedShipments)
                ]);
              },
            )),
      ),
    );
  }
}

ListView _shipments(List<Shipment> shipment) {
  shipment = shipment.reversed.toList();
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

List<Widget> _newShipments(List<Shipment> shipments) {
  return shipments
      .map((e) => Padding(
            padding: const EdgeInsets.all(12.0),
            child: Expanded(
              child: ExpansionTile(
                  title: Row(
                    children: [
                      const Text("Destination : "),
                      Text(e.destination),
                    ],
                  ),
                  subtitle: SizedBox(
                    height: 60.0,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text("Client : "),
                            Text(e.clientId),
                          ],
                        ),
                        Row(
                          children: const [
                            Text("Date Created-"),
                            Text("2021-10-04"),
                          ],
                        ),
                        Row(
                          children: const [
                            Text("Status"),
                            Text("Ready for Shipment"),
                          ],
                        )
                      ],
                    ),
                  ),
                  leading: const Icon(
                    Icons.folder,
                    size: 40.0,
                    color: Colors.blue,
                  ),
                  //trailing: Icon(
                  //  Icons.sync,
                  // color: Colors.green,
                  // ),
                  children: [
                    const Text("Samples"),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {},
                          child: const Text("Accept Shipment")),
                    )
                  ]),
            ),
          ))
      .toList();
}
