import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/consts/constants.dart';
import 'package:sample_tracking_system_flutter/models/patient.dart';
import 'package:sample_tracking_system_flutter/providers/patient_provider.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_elevated_button.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_text_form_field.dart';

class AddorUpdatePatientDialog extends StatefulWidget {
  Patient? patientData;
  AddorUpdatePatientDialog({Key? key, this.patientData}) : super(key: key);

  @override
  State<AddorUpdatePatientDialog> createState() =>
      _AddorUpdatePatientDialogState();
}

class _AddorUpdatePatientDialogState extends State<AddorUpdatePatientDialog> {
  final _formKey = GlobalKey<FormState>();
  int _value = 1;
  @override
  Widget build(BuildContext context) {
    bool isNewForm = widget.patientData == null;
    final Patient _patient = widget.patientData ?? Patient();

    String _appBarText = isNewForm ? 'Add' : 'Update';
    String _saveButtonText = isNewForm ? 'Save' : 'Update';

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
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
                        initialValue: _patient.firstname,
                        onSaved: (value) {
                          if (value != null) _patient.firstname = value;
                        },
                      ),
                      CustomTextFormField(
                        labelText: "Last Name",
                        initialValue: _patient.lastname,
                        onSaved: (value) {
                          if (value != null) _patient.lastname = value;
                        },
                      ),
                      // DropdownButton(
                      //   value: _value,
                      //   items: [
                      //     const DropdownMenuItem(
                      //       child: Text("First Item"),
                      //       value: 1,
                      //     ),
                      //     DropdownMenuItem(
                      //       child: Text("Second Item"),
                      //       value: 2,
                      //     )
                      //   ],
                      //   // onChanged: (int value) {
                      //   //   setState(() {
                      //   //     // _value = value;
                      //   //   });
                      //   // },
                      // ),
                      CustomTextFormField(
                        labelText: "Date of birth",
                        initialValue: _patient.dob,
                        onSaved: (value) {
                          if (value != null) _patient.dob = value;
                        },
                      ),
                      CustomTextFormField(
                        labelText: "Client",
                        initialValue: _patient.client,
                        onSaved: (value) {
                          if (value != null) _patient.client = value;
                        },
                      ),
                      CustomTextFormField(
                        labelText: "Cohort Number",
                        initialValue: _patient.cohortNumber,
                        onSaved: (value) {
                          if (value != null) _patient.cohortNumber = value;
                        },
                      ),
                      Visibility(
                        visible: !isNewForm,
                        child: CustomTextFormField(
                          labelText: "Date created",
                          enabled: false,
                          initialValue: getDateCreated(),
                          onSaved: (value) {
                            if (value != null) {
                              _patient.dateCreated = DateTime.now().toString();
                            }
                          },
                        ),
                      ),
                      Visibility(
                        visible: !isNewForm,
                        child: CustomTextFormField(
                          enabled: false,
                          initialValue: getDateModified(),
                          labelText: "Date Modified",
                          onSaved: (value) {
                            if (value != null) {
                              _patient.dateModified = DateTime.now().toString();
                            }
                          },
                        ),
                      ),
                      CustomElevatedButton(
                          labelText: "$_saveButtonText Patient",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              _patient.dateModified = _patient.dateCreated =
                                  DateTime.now().toString();

                              widget.patientData == null
                                  ? addNewSample(context, _patient)
                                  : updateSample(context, _patient);

                              showNotification(context);
                              Navigator.of(context).pop();
                            }
                          }),
                    ],
                  ),
                )
              ],
            )));
  }

  String getDateModified() {
    if (widget.patientData != null) {
      return widget.patientData!.dateModified.toString();
    }
    return DateTime.now().toString();
  }

  String getDateCreated() {
    if (widget.patientData != null) {
      return widget.patientData!.dateCreated.toString();
    }
    return DateTime.now().toString();
  }

  void addNewSample(BuildContext context, Patient _patient) {
    Provider.of<PatientProvider>(context, listen: false).add(_patient);
  }

  void updateSample(BuildContext context, Patient _patient) {
    Provider.of<PatientProvider>(context, listen: false)
        .updatePatient(_patient);
  }

  void showNotification(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Patient saved"),
        backgroundColor: Colors.green,
      ),
    );
  }
}
