// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/features/patient/patients_tab.dart';
import 'package:sample_tracking_system_flutter/features/sample/samples_tab.dart';
import 'package:sample_tracking_system_flutter/features/shipment/shipments_screen.dart';

import 'facility_dashboard.dart';

class HomePage extends StatefulWidget {
  int pageIndex;
  HomePage({Key? key, this.pageIndex = 0}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const FacilityDashboard(),
    const PatientsTab(),
    const SamplesTab(),
    const ShipmentsTab()
  ];

  @override
  Widget build(BuildContext context) {
    if (widget.pageIndex > 0) {
      _currentIndex = widget.pageIndex;
      widget.pageIndex = 0;
    }

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.onSurface,
        unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
        selectedLabelStyle: textTheme.caption,
        unselectedLabelStyle: textTheme.caption,
        onTap: (value) {
          // Respond to item press.
          setState(() => _currentIndex = value);
        },
        items: const [
          BottomNavigationBarItem(
            label: "Dashboard",
            icon: Icon(Icons.apps),
          ),
          BottomNavigationBarItem(
            label: "Patients",
            icon: Icon(Icons.personal_injury),
          ),
          BottomNavigationBarItem(
            label: "Samples",
            icon: Icon(Icons.biotech),
          ),
          BottomNavigationBarItem(
            label: "Shipments",
            icon: Icon(Icons.moped),
          )
          // BottomNavigationBarItem(
          //   label: "Settings",
          //   icon: Icon(Icons.settings),
          // ),
        ],
      ),
    );
  }
}
