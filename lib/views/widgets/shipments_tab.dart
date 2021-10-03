import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:sample_tracking_system_flutter/providers/shipment_provider.dart';
import 'package:sample_tracking_system_flutter/views/dialogs/add_shipment.dart';

class ShipmentsTab extends StatefulWidget {
  const ShipmentsTab({Key? key}) : super(key: key);

  @override
  _ShipmentsTabState createState() => _ShipmentsTabState();
}

class _ShipmentsTabState extends State<ShipmentsTab> {
  @override
  void didChangeDependencies() {
    getSamples();
    super.didChangeDependencies();
  }

  void getSamples() {
    Provider.of<ShipmentProvider>(context, listen: false)
        .allShipmentsFromdatabase();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: "Local"),
                Tab(text: "Awaiting collection"),
              ],
            ),
            leading: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        AddorUpdateShipmentDialog(),
                    fullscreenDialog: true,
                  ),
                );
              },
            ),
            title: const Text("Shipments"),
            backgroundColor: Colors.blue,
          ),
          body: TabBarView(children: [
            Consumer<ShipmentProvider>(
                builder: (context, shipmentProvider, child) {
              return _localShipments(shipmentProvider.shipments);
            }),
            Column(
              children: [..._newShipments()],
            )
          ])),
    );
  }

  ListView _localShipments(List<Shipment> shipment) {
    shipment = shipment.reversed.toList();
    return ListView.builder(
      itemCount: shipment.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    AddorUpdateShipmentDialog(shipmentData: shipment[index]),
                fullscreenDialog: true,
              ),
            );
          },
          title: Text(shipment[index].id.toString()),
          subtitle: const Text('Shipping description'),
          leading: const Icon(
            Icons.file_present,
            color: Colors.blue,
          ),
          trailing: const Icon(
            Icons.sync,
            color: Colors.green,
          ),
        );
      },
    );
  }
}

List<Widget> _newShipments() {
  //get new shipments list
  var shipments = [
    Shipment(
        id: "1",
        clientId: "1",
        status: "readyForCollection",
        samples: [],
        destination: "Harare",
        dateCreated: DateUtils.dateOnly(DateTime.now()).toString()),
    Shipment(
        id: "2",
        clientId: "2",
        status: "readyForCollection",
        samples: [],
        destination: "Norton",
        dateCreated: DateUtils.dateOnly(DateTime.now()).toString()),
    Shipment(
        id: "3",
        clientId: "3",
        status: "readyForCollection",
        samples: [],
        destination: "Zvimba",
        dateCreated: DateUtils.dateOnly(DateTime.now()).toString())
  ];

  return shipments
      .map((e) => Padding(
            padding: const EdgeInsets.all(12.0),
            child: ExpansionTile(
                title: Row(
                  children: [
                    const Text("Destination : "),
                    Text(e.destination ?? "Destination unspecified"),
                  ],
                ),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        const Text("Client : "),
                        Text(e.clientId ?? "X"),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Text("Date Created: "),
                          Text(e.dateCreated ?? "X"),
                        ],
                      ),
                    ),
                    Row(
                      children: const [
                        Text("Status"),
                        Text("Ready for Shipment"),
                      ],
                    )
                  ],
                ),
                leading: const Icon(
                  Icons.folder,
                  size: 300.0,
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
                        onPressed: () {}, child: const Text("Start Shipping")),
                  )
                ]),
          ))
      .toList();
}
