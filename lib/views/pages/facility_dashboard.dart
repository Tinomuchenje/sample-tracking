import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample_tracking_system_flutter/views/widgets/grid_dashboard.dart';

class FacilityDashboard extends StatefulWidget {
  const FacilityDashboard({Key? key}) : super(key: key);

  @override
  _FacilityDashboardState createState() => _FacilityDashboardState();
}

class _FacilityDashboardState extends State<FacilityDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const SizedBox(height: 60.0),
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
                          onPressed: () {},
                          icon: const Icon(Icons.notifications)),
                      IconButton(
                          alignment: Alignment.topRight,
                          color: Colors.grey,
                          iconSize: 40,
                          onPressed: () {},
                          icon: const Icon(Icons.settings))
                    ],
                  ),
                ])),
        const SizedBox(
          height: 10.0,
        ),
        GridDashBoard(),
      ]),
    );
  }
}
