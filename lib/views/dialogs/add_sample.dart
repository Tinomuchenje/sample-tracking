import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/consts/constants.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/providers/samples_provider.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_elevated_button.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_text_form_field.dart';

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

  @override
  Widget build(BuildContext context) {
    final Sample _sample = widget.sampleData ?? Sample();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Add Sample'),
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
                      labelText: "Sample Request ID",
                      initialValue: _sample.sample_request_id,
                      onSaved: (value) {
                        if (value != null) _sample.sample_request_id = value;
                      },
                    ),
                    CustomTextFormField(
                      labelText: "Client Sample ID",
                      initialValue: _sample.client_sample_id,
                      onSaved: (value) {
                        if (value != null) _sample.client_sample_id = value;
                      },
                    ),
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
                      labelText: "Client Id",
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
                      labelText: "Date Collected",
                      initialValue: DateTime.now().toString(),
                      onSaved: (value) {
                        if (value != null) _sample.date_collected = value;
                      },
                    ),
                    CustomTextFormField(
                      labelText: "Status",
                      initialValue: _sample.status,
                      onSaved: (value) {
                        if (value != null) _sample.status = value;
                      },
                    ),
                    CheckboxListTile(
                      title: const Text("Synced"),
                      value: _synced,
                      onChanged: (newValue) {
                        setState(() {
                          _sample.synced = newValue;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    CustomTextFormField(
                      labelText: "Date Synced",
                      initialValue: _sample.date_synced,
                      onSaved: (value) {
                        if (value != null) {
                          _sample.date_synced = DateTime.now().toString();
                        }
                      },
                    ),
                    CustomTextFormField(
                      labelText: "Lab Reference Id",
                      initialValue: _sample.lab_reference_id,
                      onSaved: (value) {
                        if (value != null) _sample.lab_reference_id = value;
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
                      labelText: "Shipment Id",
                      initialValue: _sample.shipment_id,
                      onSaved: (value) {
                        if (value != null) _sample.shipment_id = value;
                      },
                    ),
                    CustomTextFormField(
                      labelText: "Client Contact",
                      initialValue: _sample.client_contact,
                      onSaved: (value) {
                        if (value != null) _sample.client_contact = value;
                      },
                    ),
                    CustomElevatedButton(
                      labelText: "Save Sample",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

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

  void addNewSample(Sample _sample, BuildContext context) {
    _sample.modified_at = _sample.created_at = DateTime.now().toString();

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
