import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:sample_tracking_system_flutter/models/enums/user_type_enum.dart';
import 'package:sample_tracking_system_flutter/views/shipment/state/shipment_provider.dart';
import 'package:sample_tracking_system_flutter/views/shipment/add_shipment_screen.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_card.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_sync_status.dart';

class ShipmentsTab extends StatefulWidget {
  const ShipmentsTab({Key? key}) : super(key: key);

  @override
  _ShipmentsTabState createState() => _ShipmentsTabState();
}

class _ShipmentsTabState extends State<ShipmentsTab> {
  var currentUser;

  @override
  void didChangeDependencies() {
    //currentUser = Provider.of<UserProvider>(context, listen: false).currentUser;
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
        body: Consumer<ShipmentProvider>(
            builder: (context, shipmentProvider, child) {
          return TabBarView(children: [
            _shipments(shipmentProvider.clientShipments),
            _shipments(shipmentProvider.hubShipments),
            _shipments(shipmentProvider.labShipments),
            _shipments(shipmentProvider.closedShipments)
          ]);
        }),
      ),
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
