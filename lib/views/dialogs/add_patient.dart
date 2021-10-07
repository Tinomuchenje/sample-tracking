import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  var dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(1900),
        lastDate: date);
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController = TextEditingController(text: selectedDate.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isNewForm = widget.patientData == null;
    final Patient _patient = widget.patientData ?? Patient();

    String _appBarText = isNewForm ? 'Add' : 'Update';
    String _saveButtonText = isNewForm ? 'Save' : 'Update';
    bool _value = false;
    int val = -1;
    String? _selectedGender = 'male';

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
                      CustomTextFormField(
                        labelText: "Cohort Number",
                        initialValue: _patient.cohortNumber,
                        onSaved: (value) {
                          if (value != null) _patient.cohortNumber = value;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            // icon: Icon(Icons.date_range_outlined),
                            border: OutlineInputBorder(),
                            labelText: "Date of birth",
                          ),
                          onTap: () => _selectDate(context),
                          onSaved: (value) {
                            if (value != null) _patient.dob = value;
                          },
                          controller: dateController,
                        ),
                      ),
                      Row(
                        children: [
                          ListTile(
                            title: const Text("Male"),
                            leading: Radio(
                              value: "male",
                              groupValue: _selectedGender,
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedGender = value;
                                });
                              },
                              activeColor: Colors.green,
                            ),
                          ),
                          ListTile(
                            title: const Text("Female"),
                            leading: Radio(
                              value: "female",
                              groupValue: _selectedGender,
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedGender = value;
                                });
                              },
                              activeColor: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: !isNewForm,
                        child: CustomTextFormField(
                          labelText: "Client",
                          initialValue: _patient.client,
                          onSaved: (value) {
                            if (value != null) _patient.client = value;
                          },
                        ),
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
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 45,
                            width: 150,
                            child: CustomElevatedButton(
                                displayText: "$_saveButtonText Patient",
                                fillcolor: false,
                                press: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();

                                    widget.patientData == null
                                        ? addNewPatient(context, _patient)
                                        : updatePatient(context, _patient);

                                    showNotification(context);
                                    Navigator.of(context).pop();
                                  }
                                }),
                          ),
                          SizedBox(
                            height: 45,
                            width: 150,
                            child: CustomElevatedButton(
                                displayText: "$_saveButtonText & Add Sample",
                                fillcolor: true,
                                press: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();

                                    widget.patientData == null
                                        ? addNewPatient(context, _patient)
                                        : updatePatient(context, _patient);

                                    showNotification(context);
                                    Navigator.of(context).pop();
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

  void addNewPatient(BuildContext context, Patient _patient) {
    Provider.of<PatientProvider>(context, listen: false).add(_patient);
  }

  void updatePatient(BuildContext context, Patient _patient) {
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
