import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/consts/constants.dart';
import 'package:sample_tracking_system_flutter/models/patient.dart';
import 'package:sample_tracking_system_flutter/providers/patient_provider.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_elevated_button.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_text_form_field.dart';

class AddPatient extends StatefulWidget {
  const AddPatient({Key? key}) : super(key: key);

  @override
  _AddPatientState createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  late Patient _patient;
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    _patient = Provider.of<PatientProvider>(context, listen: false).patient;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Add Patient'),
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
                        onSaved: (value) {
                          if (value != null) _patient.firstname = value;
                        },
                      ),
                      CustomTextFormField(
                        labelText: "Last Name",
                        onSaved: (value) {
                          if (value != null) _patient.lastname = value;
                        },
                      ),
                      CustomElevatedButton(
                          labelText: "Save Patient",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              Provider.of<PatientProvider>(context,
                                      listen: false)
                                  .add(_patient);
                              showNotification(context);
                            }
                          }),
                    ],
                  ),
                )
              ],
            )));
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
