import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/views/dialogs/add_patient.dart';

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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => AddPatient(),
                fullscreenDialog: true,
              ),
            );
          },
        ),
        title: const Text("Patients"),
      ),
    );
  }
}
