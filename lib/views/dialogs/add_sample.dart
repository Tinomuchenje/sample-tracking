import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';

class AddSampleDialog extends StatefulWidget {
  const AddSampleDialog({Key? key}) : super(key: key);

  @override
  _AddSampleDialogState createState() => _AddSampleDialogState();
}

class _AddSampleDialogState extends State<AddSampleDialog> {
  String sampleType = 'sample';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Add Sample'),
          // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.save))],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Patient ID",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Can not be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Lab ID",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Can not be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Location",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Can not be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Sample ID",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Can not be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Test ID",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Can not be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Shipment ID",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Can not be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(382, 50)),
                      ),
                      onPressed: () {
                        SampleCrud().insertSample(Sample(
                          "sample_request_id",
                          "client_sample_id",
                          "patient_id",
                          "lab_id",
                          "client_id",
                          "123",
                          "test_id",
                          DateTime.now(),
                          ",created",
                          false,
                          "lab_reference_id",
                          "result",
                          "shipment_id",
                          "client_contact",
                          DateTime.now(),
                          DateTime.now(),
                          DateTime.now(),
                          "location",
                        ));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Sample saved"),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      child: Text("save sample"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

//
// Container(
// padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
// child: ListView(
// children: <Widget>[
// SizedBox(
// height: 20,
// ),
// TextFormField(
// cursorColor: Theme.of(context).cursorColor,
// initialValue: 'P12345',
// readOnly: true,
// decoration: InputDecoration(
// labelText: 'Sample ID',
// helperText: '',
// border: OutlineInputBorder(),
// filled: true,
// ),
// ),
// TextFormField(
// cursorColor: Theme
//     .of(context)
// .cursorColor,
// initialValue: '',
// decoration: InputDecoration(
// labelText: 'Patient',
// helperText: '',
// border: OutlineInputBorder(),
// ),
// ),
// DropdownButtonFormField(
// value: sampleType,
// items: [
// DropdownMenuItem(
// value: "sample",
// child: Text("Sample"),
// ),
// DropdownMenuItem(
// value: "sample2",
// child: Text("Sample 2"),
// )
// ],
// decoration: InputDecoration(
// labelText: "Select a sample type",
// border: OutlineInputBorder(),
// ),
// onChanged: (value){
// setState(() {
// sampleType = value.toString();
// });
// },
// ),
// SizedBox(
// height: 20,
// ),
// TextFormField(
// cursorColor: Theme
//     .of(context)
// .cursorColor,
// initialValue: '',
// maxLines: 3,
// decoration: InputDecoration(
// labelText: 'Remarks',
// helperText: '',
// border: OutlineInputBorder(),
// ),
// ),
// ElevatedButton(
// onPressed: () =>
// {
//
// SampleCrud().insertSample(new Sample("sample_request_id", "client_sample_id", "patient_id", "lab_id", "client_id", "sample_id", "test_id", DateTime.now(), "status", true, "lab_reference_id", "result", "shipment_id", "client_contact", DateTime.now(), DateTime.now(), DateTime.now())),
// ScaffoldMessenger.of(context).showSnackBar(
// SnackBar(
// content: Text("Sample saved"),
// backgroundColor: Colors.green,
// ),
// )
// },
// child: Text("Save"),
// )
// ],
// ),
// )
