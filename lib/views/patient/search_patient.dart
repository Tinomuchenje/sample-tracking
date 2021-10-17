import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/models/patient.dart';
import 'package:sample_tracking_system_flutter/providers/patient_provider.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_card.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_text_elevated_button.dart';

import 'add_patient.dart';
import 'patient_details_tile.dart';

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
      child: PatientDetailsTile(patients: searchResultsList),
      replacement: registerPatient(context),
    );
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
    return clientPatientId.toLowerCase().startsWith(query.toString().toLowerCase());
  }

  Widget registerPatient(BuildContext context) {
    return Center(
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
    );
  }
}
