import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/features/patient/data_state/patient_provider.dart';
import 'package:sample_tracking_system_flutter/features/sample/state/samples_provider.dart';
import 'package:sample_tracking_system_flutter/features/shipment/state/shipment_provider.dart';

import 'custom_card.dart';

class GridDashBoard extends StatefulWidget {
  const GridDashBoard({Key? key}) : super(key: key);

  @override
  _GridDashBoardState createState() => _GridDashBoardState();
}

class _GridDashBoardState extends State<GridDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Consumer<ShipmentProvider>(
          builder: (context, shipmentProvider, child) {
        return _grid(shipmentProvider);
      }),
    );
  }

  GridView _grid(ShipmentProvider shipmentProvider) {
    return GridView.count(
      childAspectRatio: 1.0,
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      crossAxisCount: 2, // We can have a condition for bigger screen
      crossAxisSpacing: 18.0,
      mainAxisSpacing: 18.0,
      children: <Widget>[
        buildDashboardItem(
            title: "Total Shipments",
            count: shipmentProvider.shipments.length,
            icon: Icons.select_all,
            iconColor: Colors.greenAccent.shade700),
        buildDashboardItem(
            title: "Due Collection",
            count: shipmentProvider.shipments.length -
                (shipmentProvider.inprogressShipments.length +
                    shipmentProvider.closedShipments.length),
            icon: Icons.check_circle_outline,
            iconColor: Colors.redAccent),
        buildDashboardItem(
            title: "In Transit",
            count: shipmentProvider.inprogressShipments.length,
            icon: Icons.moped,
            iconColor: Colors.orangeAccent),
        buildDashboardItem(
            title: "Delivered",
            count: shipmentProvider.closedShipments.length,
            icon: Icons.all_inbox,
            iconColor: Colors.greenAccent.shade700),
        Consumer<SamplesProvider>(
          builder: (context, sampleProvider, child) {
            return buildDashboardItem(
                title: "Samples",
                count: sampleProvider.allSamples.length,
                icon: Icons.select_all,
                iconColor: Colors.greenAccent.shade700);
          },
        ),
        Consumer<PatientProvider>(
          builder: (context, patientProvider, child) {
            return buildDashboardItem(
                title: "Patients",
                count: patientProvider.patients.length,
                icon: Icons.select_all,
                iconColor: Colors.blue);
          },
        ),
      ],
    );
  }

  Widget buildDashboardItem(
      {required String title,
      int count = 0,
      required IconData icon,
      Color? iconColor}) {
    return CustomCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(title,
                  style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600)))
            ]),
          ),
          const SizedBox(height: 12),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Icon(icon, size: 45, color: iconColor),
            Text(count.toString(),
                style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                        color: iconColor,
                        fontSize: 45.0,
                        fontWeight: FontWeight.bold)))
          ])
        ],
      ),
    );
  }
}
