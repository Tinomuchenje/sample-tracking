import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/providers/samples_provider.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_text_form_field.dart';

class AddSampleDialog extends StatefulWidget {
  const AddSampleDialog({Key? key}) : super(key: key);

  @override
  _AddSampleDialogState createState() => _AddSampleDialogState();
}

class _AddSampleDialogState extends State<AddSampleDialog> {
  String sampleType = 'sample';
  late Sample _sample;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _sample = Provider.of<SamplesProvider>(context, listen: false).sample;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    CustomTextFormField(
                      labelText: "Patient ID",
                      onSaved: (value) {
                        if (value != null) _sample?.patient_id = value;
                      },
                    ),
                    CustomTextFormField(
                      labelText: "Lab ID",
                      onSaved: (value) {
                        if (value != null) _sample?.lab_id = value;
                      },
                    ),
                    CustomTextFormField(
                      labelText: "Location",
                      onSaved: (value) {
                        if (value != null) _sample?.location = value;
                      },
                    ),
                    CustomTextFormField(
                      labelText: "Sample Id",
                      onSaved: (value) {
                        if (value != null) _sample?.sample_id = value;
                      },
                    ),
                    CustomTextFormField(
                      labelText: "Test Id",
                      onSaved: (value) {
                        if (value != null) _sample?.test_id = value;
                      },
                    ),
                    CustomTextFormField(
                      labelText: "Shipment Id",
                      onSaved: (value) {
                        if (value != null) _sample?.shipment_id = value;
                      },
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(382, 50)),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          Provider.of<SamplesProvider>(context, listen: false)
                              .add(_sample);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Sample saved"),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      },
                      child: const Text("save sample"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
