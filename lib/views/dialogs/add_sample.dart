import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/consts/constants.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/providers/samples_provider.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_elevated_button.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_text_form_field.dart';

class AddorUpdateSampleDialog extends StatelessWidget {
  Sample? sampleData;
  AddorUpdateSampleDialog({Key? key, this.sampleData}) : super(key: key);

  String sampleType = 'sample';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Sample _sample = sampleData ?? Sample();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Add Sample..'),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  children: <Widget>[
                    CustomTextFormField(
                      labelText: "Patient ID",
                      initialValue: _sample.patient_id,
                      onSaved: (value) {
                        if (value != null) _sample.patient_id = value;
                      },
                    ),
                    CustomTextFormField(
                      labelText: "Lab ID",
                      initialValue: _sample.lab_id,
                      onSaved: (value) {
                        if (value != null) _sample.lab_id = value;
                      },
                    ),
                    CustomTextFormField(
                      labelText: "Location",
                      initialValue: _sample.location,
                      onSaved: (value) {
                        if (value != null) _sample.location = value;
                      },
                    ),
                    CustomTextFormField(
                      labelText: "Sample Id",
                      initialValue: _sample.sample_id,
                      onSaved: (value) {
                        if (value != null) _sample.sample_id = value;
                      },
                    ),
                    CustomTextFormField(
                      labelText: "Test Id",
                      initialValue: _sample.test_id,
                      onSaved: (value) {
                        if (value != null) _sample.test_id = value;
                      },
                    ),
                    CustomTextFormField(
                      labelText: "Shipment Id",
                      initialValue: _sample.shipment_id,
                      onSaved: (value) {
                        if (value != null) _sample.shipment_id = value;
                      },
                    ),
                    CustomElevatedButton(
                      labelText: "Save Sample",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          _sample.modified_at =
                              _sample.created_at = DateTime.now();

                          Provider.of<SamplesProvider>(context, listen: false)
                              .addSample(_sample);

                          showNotification(context);
                          Navigator.of(context);
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
