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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => AddorUpdateShipmentDialog(),
                fullscreenDialog: true,
              ),
            );
          },
        ),
        title: const Text("Shipments"),
        backgroundColor: Colors.blue,
      ),
      body: Consumer<ShipmentProvider>(
          builder: (context, shipmentProvider, child) {
        return _shipmentsList(shipmentProvider.shipments);
      }),
    );
  }

  ListView _shipmentsList(List<Shipment> shipment) {
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
