import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample_tracking_system_flutter/utils/dao/app_information_dao.dart';
import 'package:sample_tracking_system_flutter/views/authentication/login_screen.dart';
import 'package:sample_tracking_system_flutter/views/patient/patient_controller.dart';
import 'package:sample_tracking_system_flutter/views/sample/sample_controller.dart';
import 'package:sample_tracking_system_flutter/views/shipment/shipment_controller.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_app_drawer.dart';
import 'package:sample_tracking_system_flutter/widgets/grid_dashboard.dart';

class FacilityDashboard extends StatefulWidget {
  const FacilityDashboard({Key? key}) : super(key: key);

  @override
  _FacilityDashboardState createState() => _FacilityDashboardState();
}

class _FacilityDashboardState extends State<FacilityDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomAppDrawer(),
      body: Column(children: [
        const SizedBox(height: 40.0),
        Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Dashboard",
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          // alignment: Alignment.topLeft,
                          color: Colors.grey,
                          iconSize: 40,
                          onPressed: () async {
                            // Patients syncing
                            await PatientController()
                                .addPatientsOnline()
                                .then((value) async {
                              await PatientController().getOnlinePatients();
                            });

                            // Samples syncing
                            await SampleController()
                                .addSamplesOnline()
                                .then((value) async {
                              await SampleController().getOnlineSamples();

                              // Shipment syncing
                              await ShipmentController()
                                  .addShipmentsOnline()
                                  .then((value) async {
                                await ShipmentController().getOnlineShipments();
                              });
                            });
                          },
                          icon: const Icon(Icons.sync)),
                      IconButton(
                          alignment: Alignment.topRight,
                          color: Colors.grey,
                          iconSize: 40,
                          onPressed: () {
                            AppInformationDao()
                                .deleteLoggedInUser()
                                .then((value) {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                                (_) => false,
                              );
                            });
                          },
                          icon: const Icon(Icons.logout))
                    ],
                  ),
                ])),
        const SizedBox(
          height: 10.0,
        ),
        const GridDashBoard(),
      ]),
    );
  }
}
