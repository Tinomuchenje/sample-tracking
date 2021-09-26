import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/consts/constants.dart';
import 'package:sample_tracking_system_flutter/models/client.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:sample_tracking_system_flutter/providers/samples_provider.dart';
import 'package:sample_tracking_system_flutter/providers/shipment_provider.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_elevated_button.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_text_form_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddorUpdateShipmentDialog extends StatefulWidget {
  Shipment? shipmentData;
  AddorUpdateShipmentDialog({Key? key, this.shipmentData}) : super(key: key);

  @override
  State<AddorUpdateShipmentDialog> createState() =>
      _AddorUpdateShipmentDialogState();
}

class _AddorUpdateShipmentDialogState extends State<AddorUpdateShipmentDialog> {
  final _formKey = GlobalKey<FormState>();
  Client? _value;
  List<Client> _clients = [];
  List _selectedSamples = [];

  Future<void> readJson() async {
    if (_clients.isNotEmpty) return;
    var response =
        jsonDecode(await rootBundle.loadString('assets/client.json'));

    for (var client in response) {
      setState(() {
        _clients.add(Client.fromJson(client));
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    bool isNewForm = widget.shipmentData == null;
    final Shipment _shipment = widget.shipmentData ?? Shipment();

    String _appBarText = isNewForm ? 'Add' : 'Update';
    String _saveButtonText = isNewForm ? 'Save' : 'Update';

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('$_appBarText Shipment'),
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
                      labelText: "Shipment ID",
                      initialValue: _shipment.id,
                      onSaved: (value) {
                        if (value != null) _shipment.id = value;
                      },
                    ),
                    _selectClientDropdown(),
                    Consumer<SamplesProvider>(
                        builder: (context, sampleProvider, child) {
                      return samplesList(sampleProvider.samples, _shipment);
                    }),
                    Visibility(
                      visible: !isNewForm,
                      child: CustomTextFormField(
                          labelText: "Date Created",
                          enabled: false,
                          initialValue: _shipment.dateCreated),
                    ),
                    Visibility(
                      visible: !isNewForm,
                      child: CustomTextFormField(
                          labelText: "Date Modified",
                          enabled: false,
                          initialValue: _shipment.dateModified),
                    ),
                    CustomElevatedButton(
                      labelText: _saveButtonText,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          widget.shipmentData == null
                              ? addNewShipment(context, _shipment)
                              : updateShipment(context, _shipment);

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

  samplesList(List<Sample>? samples, Shipment _shipment) {
    if (samples!.isEmpty) return const Text("No samples available");

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: MultiSelectDialogField(
        items: samples
            .map((sample) => MultiSelectItem<Sample?>(
                sample, sample.patientId ?? "Something"))
            .toList(),
        buttonIcon: const Icon(Icons.add, size: 30),
        height: MediaQuery.of(context).size.height / 2.5,
        searchable: true,
        title: const Text("Samples"),
        selectedColor: Colors.blue,
        buttonText: const Text(
          "Add samples",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        onConfirm: (results) {
          _selectedSamples = results;
          _shipment.samples = [..._selectedSamples];
        },
      ),
    );
  }

  _selectClientDropdown() {
    if (_clients.isEmpty) {
      return const Text("Nothing yet");
    }

    var xxx;
    setState(() {
      xxx = _clients.map((Client client) {
        return DropdownMenuItem<Client>(
          value: client,
          child: Text(client.name ?? "Name unavailable"),
        );
      }).toList();
    });

    return Padding(
      padding: const EdgeInsets.all(defaultPadding / 2),
      child: DropdownButtonFormField(
        value: _value,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        hint: const Text("Please select client"),
        items: xxx,
        onChanged: (value) {
          _value = value as Client;
        },
      ),
    );
  }

  String getDateModified() {
    if (widget.shipmentData != null) {
      return widget.shipmentData!.dateModified.toString();
    }
    return DateTime.now().toString();
  }

  String getDateCreated() {
    if (widget.shipmentData != null) {
      return widget.shipmentData!.dateCreated.toString();
    }
    return DateTime.now().toString();
  }

  void addNewShipment(BuildContext context, Shipment _shipment) {
    _shipment.dateCreated = _shipment.dateModified = DateTime.now().toString();
    Provider.of<ShipmentProvider>(context, listen: false)
        .addShipment(_shipment);
  }

  void updateShipment(BuildContext context, Shipment _shipment) {
    Provider.of<ShipmentProvider>(context, listen: false)
        .updateShipment(_shipment);
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
