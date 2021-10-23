import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/models/patient.dart';
import 'package:sample_tracking_system_flutter/views/sample/add_sample.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_card.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_text_elevated_button.dart';

import 'add_patient.dart';

class PatientDetailsTile extends StatefulWidget {
  List<Patient> patients;

  PatientDetailsTile({Key? key, required this.patients}) : super(key: key);

  @override
  _PatientDetailsTileState createState() => _PatientDetailsTileState();
}

class _PatientDetailsTileState extends State<PatientDetailsTile> {
  @override
  Widget build(BuildContext context) {
    List<Patient> patientsFound = widget.patients;

    return ListView.builder(
        itemBuilder: (context, index) => Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 12, 8.0, 12.0),
                child: CustomCard(
                  child: ExpansionTile(
                    collapsedTextColor: Colors.grey,
                    textColor: Colors.grey,
                    iconColor: Colors.blue,
                    collapsedIconColor: Colors.blue,
                    leading:
                        const Icon(Icons.person, color: Colors.blue, size: 40),
                    title: SizedBox(
                      height: 30,
                      child: Row(
                        children: [
                          Text(patientsFound[index].firstName + " "),
                          Text(patientsFound[index].lastName),
                        ],
                      ),
                    ),
                    subtitle: Column(children: [
                      SizedBox(
                        height: 20,
                        child: Row(
                          children: [
                            const Text("DOB: "),
                            Text(patientsFound[index].dob)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        child: Row(
                          children: [
                            const Text("Client Patient Id: "),
                            Text(patientsFound[index].clientPatientId)
                          ],
                        ),
                      ),
                    ]),
                    children: [
                      SizedBox(
                        height: 60,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _editPatient(context, patientsFound, index),
                              _addSample(context, patientsFound, index)
                            ]),
                      )
                    ],
                  ),
                ),
              ),
            ),
        itemCount: patientsFound.length);
  }

  SizedBox _addSample(
      BuildContext context, List<Patient> patientsFound, int index) {
    return SizedBox(
      width: 130,
      child: CustomElevatedButton(
          displayText: "Add Sample",
          fillcolor: true,
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    AddorUpdateSampleDialog(patient: patientsFound[index]),
              ),
            );
          }),
    );
  }

  SizedBox _editPatient(
      BuildContext context, List<Patient> patientsFound, int index) {
    return SizedBox(
      width: 130,
      child: CustomElevatedButton(
        displayText: 'Edit',
        fillcolor: false,
        press: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => AddorUpdatePatientDialog(
                patientData: patientsFound[index],
              ),
              fullscreenDialog: true,
            ),
          );
        },
      ),
    );
  }
}
