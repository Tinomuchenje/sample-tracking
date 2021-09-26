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
                      initialValue: _sample.sampleRequestId,
                      onSaved: (value) {
                        if (value != null) _sample.sampleRequestId = value;
                      },
                    ),
                    CustomTextFormField(
                      labelText: "Client Sample ID",
                      initialValue: _sample.clientSampleId,
                      onSaved: (value) {
                        if (value != null) _sample.clientSampleId = value;
                      },
                    ),
                    CustomTextFormField(
                      labelText: "Patient ID",
                      initialValue: _sample.patientId,
                      onSaved: (value) {
                        if (value != null) _sample.patientId = value;
                      },
                    ),
                    CustomTextFormField(
                      labelText: "Lab ID",
                      initialValue: _sample.labId,
                      onSaved: (value) {
                        if (value != null) _sample.labId = value;
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
                      initialValue: _sample.sampleId,
                      onSaved: (value) {
                        if (value != null) _sample.sampleId = value;
                      },
                    ),
                    CustomTextFormField(
                      labelText: "Test Id",
                      initialValue: _sample.testId,
                      onSaved: (value) {
                        if (value != null) _sample.testId = value;
                      },
                    ),
                    CustomTextFormField(
                      labelText: "Date Collected",
                      initialValue: DateTime.now().toString(),
                      onSaved: (value) {
                        if (value != null) _sample.dateCollected = value;
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
                      initialValue: _sample.dateSynced,
                      onSaved: (value) {
                        if (value != null) {
                          _sample.dateSynced = DateTime.now().toString();
                        }
                      },
                    ),
                    CustomTextFormField(
                      labelText: "Lab Reference Id",
                      initialValue: _sample.labReferenceId,
                      onSaved: (value) {
                        if (value != null) _sample.labReferenceId = value;
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
                      initialValue: _sample.shipmentId,
                      onSaved: (value) {
                        if (value != null) _sample.shipmentId = value;
                      },
                    ),
                    CustomTextFormField(
                      labelText: "Client Contact",
                      initialValue: _sample.clientContact,
                      onSaved: (value) {
                        if (value != null) _sample.clientContact = value;
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
