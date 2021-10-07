import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/consts/constants.dart';
import 'package:sample_tracking_system_flutter/models/laboritory.dart';
import 'package:sample_tracking_system_flutter/models/patient.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/providers/patient_provider.dart';
import 'package:sample_tracking_system_flutter/providers/samples_provider.dart';
import 'package:sample_tracking_system_flutter/utils/dao/laboratory_dao.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_elevated_button.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_form_dropdown.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_text_form_field.dart';

import 'add_patient.dart';

class AddorUpdateSampleDialog extends StatefulWidget {
  Sample? sampleData;
  AddorUpdateSampleDialog({Key? key, this.sampleData}) : super(key: key);

  @override
  State<AddorUpdateSampleDialog> createState() =>
      _AddorUpdateSampleDialogState();
}

class _AddorUpdateSampleDialogState extends State<AddorUpdateSampleDialog> {
  final _formKey = GlobalKey<FormState>();
  final bool _synced = false;
  LaboratoryDao laboratoryDao = LaboratoryDao();

  @override
  Widget build(BuildContext context) {
    bool isNewForm = widget.sampleData == null;
    final Sample _sample = widget.sampleData ?? Sample();

    String _appBarText = isNewForm ? 'Add' : 'Update';
    String _saveButtonText = isNewForm ? 'Save' : 'Update';

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('$_appBarText Sample'),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(defaultPadding / 2),
                child: Column(
                  children: <Widget>[
                    // CustomTextFormField(
                    //   labelText: "Sample Request ID",
                    //   initialValue: _sample.sampleRequestId,
                    //   onSaved: (value) {
                    //     if (value != null) _sample.sampleRequestId = value;
                    //   },
                    // ),
                    // CustomTextFormField(
                    //   labelText: "Client Sample ID",
                    //   initialValue: _sample.clientSampleId,
                    //   onSaved: (value) {
                    //     if (value != null) _sample.clientSampleId = value;
                    //   },
                    // ),
                    Consumer<PatientProvider>(
                        builder: (context, patientProvider, child) {
                      return _patientsDropdown(
                          _sample, patientProvider.patients);
                    }),
                    //_laboratoriesDropdown(_sample),
                    // CustomTextFormField(
                    //   labelText: "Client Id",
                    //   initialValue: _sample.location,
                    //   onSaved: (value) {
                    //     if (value != null) _sample.location = value;
                    //   },
                    // ),
                    CustomTextFormField(
                      labelText: "Sample Types",
                      initialValue: _sample.sampleId,
                      onSaved: (value) {
                        if (value != null) _sample.sampleId = value;
                      },
                    ),
                    _testsDropdown(_sample),
                    Visibility(
                      visible: !isNewForm,
                      child: CustomTextFormField(
                        enabled: false,
                        labelText: "Date Collected",
                        initialValue: _sample.dateCollected,
                      ),
                    ),
                    Visibility(
                      visible: !isNewForm,
                      child: CustomTextFormField(
                        enabled: false,
                        labelText: "Status",
                        initialValue: _sample.status,
                      ),
                    ),
                    Visibility(
                      visible: !isNewForm,
                      child: CustomTextFormField(
                          enabled: false,
                          labelText: "Date Synced",
                          initialValue: _sample.dateSynced),
                    ),
                    Visibility(
                      visible: !isNewForm,
                      child: CustomTextFormField(
                          enabled: false,
                          labelText: "Lab Reference Id",
                          initialValue: _sample.labReferenceId),
                    ),
                    Visibility(
                      visible: !isNewForm,
                      child: CustomTextFormField(
                          enabled: false,
                          labelText: "Location",
                          initialValue: "Hurungwe"),
                    ),
                    Visibility(
                      visible: !isNewForm,
                      child: CustomTextFormField(
                        labelText: "Shipment",
                        initialValue: _sample.shipmentId,
                      ),
                    ),
                    Visibility(
                      visible: !isNewForm,
                      child: CustomTextFormField(
                          enabled: false,
                          labelText: "Client Contact",
                          initialValue: "Admin"),
                    ),
                    CustomElevatedButton(
                      displayText: "$_saveButtonText Sample",
                      fillcolor: true,
                      press: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          _sample.status = "Created";
                          _sample.synced = false;
                          _sample.clientSampleId = "SFDFASDS";

                          _sample.dateSynced =
                              _sample.dateCollected = DateTime.now().toString();

                          widget.sampleData == null
                              ? addNewSample(_sample, context)
                              : updateSample(_sample, context);

                          showNotification(context);
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  _patientsDropdown(Sample _sample, List<Patient> patients) {
    //Add button to add patient pop up
    if (patients.isEmpty) {
      return CustomElevatedButton(
          displayText: "Add Patient",
          fillcolor: true,
          press: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            AddorUpdatePatientDialog()))
              });
    }

    var patientsList = patients.map((Patient patient) {
      return "${patient.firstname} ${patient.lastname}";
    }).toList();

    var _selected;
    return Padding(
      padding: const EdgeInsets.all(defaultPadding / 2),
      child: DropdownSearch<String>(
        mode: Mode.DIALOG,
        showSearchBox: true,
        showSelectedItems: true,
        items: patientsList,
        hint: "Select Patient",
        onChanged: print,
        onSaved: (value) {
          if (value != null) _sample.patientId = value.toString();
        },
        // selectedItem: _selected
      ),
    );
  }

  _testsDropdown(Sample _sample) {
    var _test;
    var testMenus = [
      const DropdownMenuItem<String>(
        value: "Covid",
        child: Text("Covid"),
      ),
      const DropdownMenuItem<String>(
        value: "Tb",
        child: Text("Tb"),
      )
    ];

    return CustomFormDropdown(
      value: _test ?? _sample.labId,
      hint: const Text("Select Test"),
      items: testMenus,
      onSaved: (value) {
        _sample.labId = value.toString();
      },
      onChanged: (value) {
        _test = value as String;
      },
    );
  }

  _laboratoriesDropdown(Sample _sample) {
    Laboratory? _laboratory;
    return FutureBuilder(
        future: laboratoryDao.getAllLabs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Text("Loading Labs");
          }

          List<Laboratory>? labs = snapshot.data as List<Laboratory>;
          List<DropdownMenuItem<String>> labMenus = [];

          labMenus = labs.map((Laboratory laboratory) {
            return DropdownMenuItem<String>(
              value: laboratory.id,
              child: Text(laboratory.name ?? "Name unavailable"),
            );
          }).toList();

          return CustomFormDropdown(
            value: _laboratory ?? _sample.labId,
            hint: const Text("Lab"),
            items: labMenus,
            onSaved: (value) {
              _sample.labId = value.toString();
            },
            onChanged: (value) {
              _laboratory = value as Laboratory;
            },
          );
        });
  }

  void addNewSample(Sample _sample, BuildContext context) {
    _sample.dateModified = _sample.dateCreated = DateTime.now().toString();

    Provider.of<SamplesProvider>(context, listen: false).addSample(_sample);
  }

  void updateSample(Sample _sample, BuildContext context) {
    Provider.of<SamplesProvider>(context, listen: false).updateSample(_sample);
  }

  void showNotification(BuildContext context) {
    // we should extract this into common area for forms
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Sample saved"),
        backgroundColor: Colors.green,
      ),
    );
  }
}
