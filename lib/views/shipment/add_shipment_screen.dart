import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/consts/constants.dart';
import 'package:sample_tracking_system_flutter/models/client.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:sample_tracking_system_flutter/providers/shipment_provider.dart';
import 'package:sample_tracking_system_flutter/views/pages/home_page.dart';
import 'package:sample_tracking_system_flutter/views/shipment/shipment_samples_screen.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_text_elevated_button.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_form_dropdown.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_text_form_field.dart';
import 'package:sample_tracking_system_flutter/views/widgets/notification_service.dart';

// ignore: must_be_immutable
class AddorUpdateShipmentDialog extends StatefulWidget {
  Shipment? shipmentData;
  AddorUpdateShipmentDialog({Key? key, this.shipmentData}) : super(key: key);

  @override
  State<AddorUpdateShipmentDialog> createState() =>
      _AddorUpdateShipmentDialogState();
}

class _AddorUpdateShipmentDialogState extends State<AddorUpdateShipmentDialog> {
  final _formKey = GlobalKey<FormState>();
  final List<Client> _clients = [];
  List<Sample> samples = [];
  int _sampleCount = 0;
  List<String> selectedSamples = [];
  bool isNewForm = false;

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
  Widget build(BuildContext context) {
    isNewForm = widget.shipmentData == null;
    String _appBarText = isNewForm ? 'Add' : 'Update';
    String _saveButtonText = isNewForm ? 'Save' : 'Update';
    Shipment _shipment = widget.shipmentData ?? Shipment(samples: []);

    if (widget.shipmentData != null) {
      selectedSamples = widget.shipmentData!.samples;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('$_appBarText Shipment Id'),
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
                      labelText: "Shipment Label",
                      initialValue: _shipment.description,
                      onSaved: (value) {
                        if (value != null) _shipment.description = value;
                      },
                    ),
                    samplesSection(_shipment),
                    _desination(_shipment),
                    CustomTextFormField(
                      keyboardType: TextInputType.number,
                      labelText: "Temperature Origin",
                      initialValue: _shipment.temperatureOrigin,
                      onSaved: (value) {
                        if (value != null) {
                          _shipment.temperatureOrigin = value;
                        }
                      },
                    ),
                    Visibility(
                      visible: !isNewForm,
                      child: const CustomTextFormField(
                          labelText: "Creater",
                          initialValue: "Admin",
                          enabled: false),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: CustomElevatedButton(
                        displayText: _saveButtonText,
                        fillcolor: true,
                        press: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            Provider.of<ShipmentProvider>(context,
                                    listen: false)
                                .addUpdateShipment(_shipment);

                            NotificationService.success(
                                context, "Saved successfully");

                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => HomePage(
                                  pageIndex: 3,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  _desination(Shipment _shipment) {
    List<String> destinations = ["Hub 1", "Lab 1"];

    var destinationMenus = destinations.map((String sampleType) {
      return DropdownMenuItem<String>(
          value: sampleType, child: Text(sampleType));
    }).toList();

    return CustomFormDropdown(
        items: destinationMenus,
        hint: const Text("Destination"),
        value: _shipment.destination.isEmpty
            ? destinations[0]
            : _shipment.destination,
        onChanged: (value) {
          _shipment.destination = value.toString();
        },
        onSaved: (value) {
          _shipment.destination = value.toString();
        });
  }

  Padding samplesSection(Shipment _shipment) {
    _sampleCount = selectedSamples.length;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextButton(
              onPressed: () {
                _formKey.currentState!.save();
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ShipmentSamples(
                      shipment: _shipment,
                    ),
                  ),
                );
              },
              child: Text(
                "View/Add Samples",
                style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                  color: Colors.blue,
                  fontSize: 15.0,
                )),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("$_sampleCount samples",
                style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ))),
          )
        ],
      ),
    );
  }
}
