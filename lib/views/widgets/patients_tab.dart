import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/models/patient.dart';
import 'package:sample_tracking_system_flutter/providers/patient_provider.dart';
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
                builder: (BuildContext context) => AddorUpdatePatientDialog(),
                fullscreenDialog: true,
              ),
            );
          },
        ),
        title: const Text("Patients"),
      ),
      body:
          Consumer<PatientProvider>(builder: (context, patientProvider, child) {
        return _samplesList(patientProvider.patients);
      }),
    );
  }

  ListView _samplesList(List<Patient> patients) {
    return ListView.builder(
      shrinkWrap: true,
      reverse: true,
      itemCount: patients.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    AddorUpdatePatientDialog(patientData: patients[index]),
                fullscreenDialog: true,
              ),
            );
          },
          title: Text(
              patients[index].firstname! + ' ' + patients[index].lastname!),
          subtitle: const Text('Patient detals'),
          leading: const Icon(
            Icons.person,
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
