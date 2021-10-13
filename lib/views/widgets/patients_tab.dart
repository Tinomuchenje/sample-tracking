import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/models/patient.dart';
import 'package:sample_tracking_system_flutter/providers/patient_provider.dart';
import 'package:sample_tracking_system_flutter/views/dialogs/add_patient.dart';
import 'package:sample_tracking_system_flutter/views/dialogs/add_sample.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_card.dart';

import 'custom_elevated_button.dart';

class PatientsTab extends StatefulWidget {
  const PatientsTab({Key? key}) : super(key: key);

  @override
  _PatientsTabState createState() => _PatientsTabState();
}

class _PatientsTabState extends State<PatientsTab> {
  List<Patient> _patients = [];

  @override
  void didChangeDependencies() {
    getSamples();
    super.didChangeDependencies();
  }

  void getSamples() {
    _patients = Provider.of<PatientProvider>(context, listen: false).patients;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search Patients"), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            showSearch(context: context, delegate: PatientSearch());
          },
        )
      ]),
      body:
          Consumer<PatientProvider>(builder: (context, patientProvider, child) {
        return PatientSearch()._buildSearchResultTile(patientProvider.patients);
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
          subtitle: const Text('Patient details'),
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

class PatientSearch extends SearchDelegate<Patient> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, Patient());
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return SizedBox(
      height: 100.0,
      width: 100,
      child: CustomCard(child: Center(child: Text(query))),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Patient> _patients =
        Provider.of<PatientProvider>(context, listen: false).patients;

    final searchResultsList = buildSearchResults(_patients);

    return Visibility(
        visible: searchResultsList.isNotEmpty,
        child: _buildSearchResultTile(searchResultsList),
        replacement: Center(
          child: SizedBox(
            height: 50,
            width: 150,
            child: CustomElevatedButton(
              displayText: 'Register Patient',
              fillcolor: true,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          AddorUpdatePatientDialog()),
                );
              },
            ),
          ),
        ));
  }

  List<Patient> buildSearchResults(List<Patient> _patients) {
    return _patients.where((patient) {
      return searchOptions(patient);
    }).toList();
  }

  bool searchOptions(Patient patient) {
    return firstname(patient.firstname) ||
        lastname(patient.lastname) ||
        clientPatientId(patient.clientPatientId);
  }

  bool lastname(String? lastname) {
    if (lastname == null) return false;
    return lastname.toLowerCase().contains(query.toLowerCase());
  }

  bool firstname(String? firstname) {
    if (firstname == null) return false;
    return firstname.toLowerCase().contains(query.toLowerCase());
  }

  bool clientPatientId(String? clientPatientId) {
    if (clientPatientId == null) return false;
    return clientPatientId.toLowerCase().startsWith(query.toLowerCase());
  }

  Widget _buildSearchResultTile(List<Patient> patientsFound) {
    if (patientsFound.isEmpty) return const Text("No patient found.");
    var color = Colors.blue;
    return ListView.builder(
        itemBuilder: (context, index) => Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 12, 8.0, 12.0),
                child: CustomCard(
                  child: ExpansionTile(
                    collapsedTextColor: Colors.grey,
                    // backgroundColor: color,
                    textColor: Colors.grey,
                    iconColor: color,
                    collapsedIconColor: color,
                    leading:
                        const Icon(Icons.person, color: Colors.blue, size: 40),
                    title: SizedBox(
                      height: 30,
                      child: Row(
                        children: [
                          Text(patientsFound[index].firstname! + " "),
                          Text(patientsFound[index].lastname ?? ""),
                        ],
                      ),
                    ),
                    subtitle: Column(children: [
                      SizedBox(
                        height: 20,
                        child: Row(
                          children: const [Text("DOB: "), Text("12/07/96")],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        child: Row(
                          children: [
                            const Text("Client Patient Id: "),
                            Text(patientsFound[index].clientPatientId ?? "")
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
                              SizedBox(
                                width: 130,
                                child: CustomElevatedButton(
                                  displayText: 'Edit',
                                  fillcolor: false,
                                  press: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            AddorUpdatePatientDialog(
                                          patientData: patientsFound[index],
                                        ),
                                        fullscreenDialog: true,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 130,
                                child: CustomElevatedButton(
                                    displayText: "Add Sample",
                                    fillcolor: true,
                                    press: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              AddorUpdateSampleDialog(
                                                  patient:
                                                      patientsFound[index]),
                                        ),
                                      );
                                    }),
                              )
                            ]),
                      )
                    ],
                  ),
                ),
              ),
            ),
        itemCount: patientsFound.length);
  }
}
