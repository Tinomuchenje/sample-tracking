import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/consts/constants.dart';
import 'package:sample_tracking_system_flutter/consts/routing_constants.dart';
import 'package:sample_tracking_system_flutter/models/patient.dart';
import 'package:sample_tracking_system_flutter/utils/date_service.dart';
import 'package:sample_tracking_system_flutter/views/patient/data_state/patient_provider.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_date_form_field.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_text_elevated_button.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_text_form_field.dart';
import 'package:sample_tracking_system_flutter/widgets/notification_service.dart';

enum Gender { male, female }

class AddorUpdatePatientDialog extends StatefulWidget {
  Patient? patientData;
  AddorUpdatePatientDialog({Key? key, this.patientData}) : super(key: key);

  @override
  State<AddorUpdatePatientDialog> createState() =>
      _AddorUpdatePatientDialogState();
}

class _AddorUpdatePatientDialogState extends State<AddorUpdatePatientDialog> {
  final _formKey = GlobalKey<FormState>();

  var dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String _gender = "male";

  @override
  Widget build(BuildContext context) {
    bool isNewForm = widget.patientData == null;
    final Patient _patient = widget.patientData ?? Patient();

    String _appBarText = isNewForm ? 'Add' : 'Update';
    String _saveButtonText = isNewForm ? 'Save' : 'Update';

    _gender = _patient.gender.isNotEmpty ? _patient.gender : _gender;

    return Scaffold(
        appBar: AppBar(
          title: Text('$_appBarText Patient'),
        ),
        body: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      CustomTextFormField(
                        labelText: "First Name",
                        initialValue: _patient.firstName,
                        onSaved: (value) {
                          if (value != null) _patient.firstName = value;
                        },
                      ),
                      CustomTextFormField(
                        labelText: "Last Name",
                        initialValue: _patient.lastName,
                        onSaved: (value) {
                          if (value != null) _patient.lastName = value;
                        },
                      ),
                      CustomTextFormField(
                        labelText: "Cohort Number",
                        initialValue: _patient.cohortNumber,
                        onSaved: (value) {
                          if (value != null) _patient.cohortNumber = value;
                        },
                      ),
                      CustomTextFormField(
                        labelText: "Client Patient Id",
                        initialValue: _patient.clientPatientId,
                        onSaved: (value) {
                          if (value != null) _patient.clientPatientId = value;
                        },
                      ),
                      CustomTextFormField(
                        labelText: "Phone number",
                        keyboardType: TextInputType.phone,
                        initialValue: _patient.phoneNumber,
                        onSaved: (value) {
                          if (value != null) _patient.phoneNumber = value;
                        },
                      ),
                      DateFormField(
                        labelText: "Date of birth",
                        initialValue:
                            _patient.dob.isEmpty ? null : _patient.dob,
                        onSaved: (value) {
                          if (value != null) _patient.dob = value.toString();
                        },
                      ),
                      Column(
                        children: <Widget>[
                          ListTile(
                            title: const Text('Male'),
                            leading: Radio(
                              value: "male",
                              groupValue: _gender,
                              onChanged: (String? value) {
                                setState(() {
                                  _gender = value as String;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('Female'),
                            leading: Radio(
                              value: "female",
                              groupValue: _gender,
                              onChanged: (String? value) {
                                setState(() {
                                  _gender = value as String;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 170,
                            child: CustomElevatedButton(
                                displayText: "$_saveButtonText Patient",
                                fillcolor: false,
                                press: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();

                                    await saveOrUpdatePatient(context, _patient)
                                        .then((value) {
                                      Navigator.of(context).pop();
                                    });
                                  }
                                }),
                          ),
                          SizedBox(
                            height: 50,
                            width: 170,
                            child: CustomElevatedButton(
                                displayText: "$_saveButtonText & Add Sample",
                                fillcolor: true,
                                press: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();

                                    await saveOrUpdatePatient(context, _patient)
                                        .then((value) => Navigator.of(context)
                                            .pushReplacementNamed(
                                                addUpdateSample,
                                                arguments: _patient));
                                  }
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )));
  }

  String getDateModified() {
    if (widget.patientData != null) {
      return widget.patientData!.lastModifiedDate.toString();
    }
    return DateTime.now().toString();
  }

  String getDateCreated() {
    if (widget.patientData != null) {
      return widget.patientData!.createdDate.toString();
    }
    return DateTime.now().toString();
  }

  Future saveOrUpdatePatient(BuildContext context, Patient _patient) async {
    _patient.gender = _gender;
    await Provider.of<PatientProvider>(context, listen: false)
        .addPatient(_patient)
        .then((value) {
      NotificationService.success(context, "Patient saved succesfully");
    });
  }
}
