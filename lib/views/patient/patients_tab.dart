import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/consts/routing_constants.dart';
import 'package:sample_tracking_system_flutter/views/patient/data_state/patient_provider.dart';

import 'patient_details_tile.dart';
import 'search_patient.dart';

class PatientsTab extends StatefulWidget {
  const PatientsTab({Key? key}) : super(key: key);

  @override
  _PatientsTabState createState() => _PatientsTabState();
}

class _PatientsTabState extends State<PatientsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.of(context).pushNamed(addUpdatePatient),
          ),
          title: const Text("Search Patients"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: PatientSearch());
              },
            )
          ]),
      body:
          Consumer<PatientProvider>(builder: (context, patientProvider, child) {
        return PatientDetailsTile(patients: patientProvider.patients);
      }),
    );
  }
}
