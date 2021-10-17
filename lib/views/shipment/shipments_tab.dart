import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:sample_tracking_system_flutter/models/enums/user_type_enum.dart';
import 'package:sample_tracking_system_flutter/providers/shipment_provider.dart';
import 'package:sample_tracking_system_flutter/providers/user_provider.dart';
import 'package:sample_tracking_system_flutter/views/shipment/add_shipment.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_card.dart';

class ShipmentsTab extends StatefulWidget {
  const ShipmentsTab({Key? key}) : super(key: key);

  @override
  _ShipmentsTabState createState() => _ShipmentsTabState();
}

class _ShipmentsTabState extends State<ShipmentsTab> {
  var currentUser;

  List<Shipment> localShipment = [Shipment(id: "Gweru", samples: [])];
  List<Shipment> hubsShipment = [Shipment(id: "Cholocho", samples: [])];
  List<Shipment> labsShipment = [Shipment(id: "Chimina", samples: [])];
  List<Shipment> closedShipment = [Shipment(id: "Seke", samples: [])];

  @override
  void didChangeDependencies() {
    currentUser = Provider.of<UserProvider>(context, listen: false).currentUser;
    getSamples();

    super.didChangeDependencies();
  }

  void getSamples() {
    Provider.of<ShipmentProvider>(context, listen: false)
        .getAllShipmentsFromdatabase();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(tabs: _renderTabs()),
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
          ),
          body: TabBarView(children: [
            Consumer<ShipmentProvider>(
                builder: (context, shipmentProvider, child) {
              return _shipments(shipmentProvider.shipments);
            }),
            _shipments(localShipment),
            _shipments(hubsShipment),
            _shipments(closedShipment)
          ])),
    );
  }

  List<Widget> _renderTabs() {
    if (currentUser == UserType.cluster) {
      return const [
        Tab(text: "Clients"),
        Tab(text: "Hub"),
        Tab(text: "Lab"),
        Tab(text: "Closed")
      ];
    } else {
      return const [
        Tab(text: "Clients"),
        Tab(text: "Hub"),
        Tab(text: "Lab"),
        Tab(text: "Closed"),
      ];
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
                        AddorUpdateShipmentDialog(
                            shipmentData: shipment[index]),
                    fullscreenDialog: true,
                  ),
                );
              },
              title: Text(shipment[index].description.toString()),
              subtitle: Row(
                children: [
                  const Text("Status:"),
                  Text(shipment[index].status ?? "Ready")
                ],
              ),
              leading: const Icon(
                Icons.folder,
                size: 45,
                color: Colors.blue,
              ),
              trailing: const Icon(
                Icons.sync,
                color: Colors.green,
              ),
            ),
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
