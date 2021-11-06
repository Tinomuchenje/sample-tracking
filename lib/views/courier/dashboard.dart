// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:sample_tracking_system_flutter/utils/dao/app_information_dao.dart';
import 'package:sample_tracking_system_flutter/views/authentication/login_screen.dart';
import 'package:sample_tracking_system_flutter/views/patient/patient_controller.dart';
import 'package:sample_tracking_system_flutter/views/sample/sample_controller.dart';
import 'package:sample_tracking_system_flutter/views/shipment/shipment_controller.dart';
import 'package:sample_tracking_system_flutter/views/shipment/state/shipment_provider.dart';
import 'package:sample_tracking_system_flutter/widgets/courier_shipment.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_app_drawer.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_card.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_logout_button.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_sync_status.dart';
import 'package:sample_tracking_system_flutter/widgets/sync_all_date.dart';

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
            appBar: AppBar(
              title: const Text("Shipments"),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [SyncAll(), LogoutButton()],
                ),
              ],
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
                  CourierShipment(
                      shipment: shipmentProvider.publishedShipments),
                  CourierShipment(
                    shipment: shipmentProvider.inprogressShipments,
                  ),
                  CourierShipment(shipment: shipmentProvider.closedShipments)
                ]);
              },
            )),
      ),
    );
  }
}
