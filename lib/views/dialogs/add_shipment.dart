import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/consts/constants.dart';
import 'package:sample_tracking_system_flutter/models/client.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/models/shipment.dart';
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
  List<Client> clients = [];

  static List<Sample> _samples = [
    Sample(sample_id: "Malaria01", patient_id: "Tino"),
    Sample(sample_id: "Malaria02", patient_id: "Tatenda")
  ];

  final _items = _samples
      .map((sample) =>
          MultiSelectItem<Sample>(sample, sample.sample_id ?? "Something"))
      .toList();

  Future<void> readJson() async {
    if (clients.isNotEmpty) return;
    var response =
        jsonDecode(await rootBundle.loadString('assets/client.json'));

    for (var client in response) {
      clients.add(Client.fromJson(client));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Shipment _shipment = widget.shipmentData ?? Shipment();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Add Shipment'),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  children: <Widget>[
                    // CustomTextFormField(
                    //   labelText: "Shipment ID",
                    //   initialValue: _shipment.Id,
                    //   onSaved: (value) {
                    //     if (value != null) _shipment.Id = value;
                    //   },
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: FutureBuilder(
                        future: readJson(),
                        builder: (context, snapshot) {
                          return dropdown();
                        },
                      ),
                    ),
                    samplesList(),
                    CustomTextFormField(
                      labelText: "Date Created",
                      enabled: false,
                      initialValue: getDateCreated(),
                      onSaved: (value) {
                        _shipment.dateCreated = value;
                      },
                    ),
                    CustomTextFormField(
                      labelText: "Date Modified",
                      enabled: false,
                      initialValue: getDateModified(),
                      onSaved: (value) {
                        if (value != null) _shipment.dateModified = value;
                      },
                    ),
                    CustomElevatedButton(
                      labelText: "Save Sample",
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

  samplesList() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: MultiSelectDialogField(
        items: _items,
        buttonIcon: const Icon(Icons.keyboard_arrow_down, size: 30),
        height: MediaQuery.of(context).size.height / 2.5,
        searchable: true,
        title: const Text("Samples"),
        selectedColor: Colors.blue,
        buttonText: const Text(
          "Add samples",
          style: TextStyle(
            // color: Colors.blue[800],
            fontSize: 16,
          ),
        ),
        onConfirm: (results) {
          //_selectedAnimals = results;
        },
      ),
    );
  }

  dropdown() {
    if (clients.isEmpty) {
      return const Text("Nothing yet");
    }
    return DropdownButton<Client>(
        hint: const Text("Please select Client"),
        value: _value,
        isExpanded: true,
        icon: const Icon(Icons.keyboard_arrow_down, size: 30),
        underline: const SizedBox(),
        items: clients.map((Client client) {
          return DropdownMenuItem<Client>(
            value: client,
            child: Text(client.name ?? "Name unavailable"),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _value = value;
          });
        });
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
