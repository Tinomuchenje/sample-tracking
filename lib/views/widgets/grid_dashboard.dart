import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/providers/patient_provider.dart';
import 'package:sample_tracking_system_flutter/providers/samples_provider.dart';
import 'package:sample_tracking_system_flutter/providers/shipment_provider.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_card.dart';

class GridDashBoard extends StatefulWidget {
  const GridDashBoard({Key? key}) : super(key: key);

  @override
  _GridDashBoardState createState() => _GridDashBoardState();
}

class _GridDashBoardState extends State<GridDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GridView.count(
        childAspectRatio: 1.0,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        crossAxisCount: 2, // We can have a condition for bigger screen
        crossAxisSpacing: 18.0,
        mainAxisSpacing: 18.0,
        children: <Widget>[
          Consumer<ShipmentProvider>(
              builder: (context, shipmentProvider, child) {
            return buildDashboardItem(
                title: "Total Shipments",
                count: shipmentProvider.shipments.length,
                icon: Icons.select_all);
          }),
          Consumer<PatientProvider>(
            builder: (context, patientProvider, child) {
              return buildDashboardItem(
                  title: "Patients",
                  count: patientProvider.patients.length,
                  icon: Icons.select_all);
            },
          ),
          Consumer<SamplesProvider>(
            builder: (context, sampleProvider, child) {
              return buildDashboardItem(
                  title: "Samples",
                  count: sampleProvider.allSamples.length,
                  icon: Icons.select_all);
            },
          ),
          buildDashboardItem(
              title: "Due Collection",
              count: 0,
              icon: Icons.check_circle_outline),
          buildDashboardItem(title: "In Transit", count: 0, icon: Icons.moped),
          buildDashboardItem(title: "Accepted", count: 0, icon: Icons.task_alt),
          buildDashboardItem(
              title: "Delivered", count: 0, icon: Icons.all_inbox),
          buildDashboardItem(
              title: "Rejected", count: 0, icon: Icons.highlight_off),
        ],
      ),
    );
  }

  Widget buildDashboardItem(
      {required String title, int count = 0, required IconData icon}) {
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
                          color: Colors.grey,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600)))
            ]),
          ),
          const SizedBox(height: 12),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Icon(
              icon,
              size: 45,
            ),
            Text(count.toString(),
                style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 45.0,
                        fontWeight: FontWeight.bold)))
          ])
        ],
      ),
    );
  }
}
