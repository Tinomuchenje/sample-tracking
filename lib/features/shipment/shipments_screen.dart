import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/consts/routing_constants.dart';

import 'package:sample_tracking_system_flutter/features/shipment/add_shipment_screen.dart';
import 'package:sample_tracking_system_flutter/features/shipment/state/shipment_provider.dart';
import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:sample_tracking_system_flutter/widgets/courier_shipment.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_card.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_sync_status.dart';

import 'create_update_shipment.dart';

class ShipmentsTab extends StatefulWidget {
  const ShipmentsTab({Key? key}) : super(key: key);

  @override
  _ShipmentsTabState createState() => _ShipmentsTabState();
}

class _ShipmentsTabState extends State<ShipmentsTab> {
  @override
  void didChangeDependencies() {
    Provider.of<ShipmentProvider>(context, listen: false)
        .getAllShipmentsFromdatabase();

    super.didChangeDependencies();
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
              // Navigator.of(context).pushNamed(createUpdateShipment);
              Provider.of<ShipmentProvider>(context, listen: false).shipment =
                  Shipment();
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      const CreateUpdateShipment(),
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
            CourierShipment(shipment: shipmentProvider.inprogressShipments),
            _shipments(shipmentProvider.closedShipments),
            _shipments(shipmentProvider.labShipments),
          ]);
        }),
      ),
    );
  }

  List<Widget> _renderTabs() {
    return const [
      Tab(text: "Clients"),
      Tab(text: "Courier"),
      Tab(text: "Hub"),
      Tab(text: "Lab"),
    ];
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
                Provider.of<ShipmentProvider>(context, listen: false).shipment =
                    shipment[index];
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const CreateUpdateShipment(),
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
