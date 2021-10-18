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
import 'package:sample_tracking_system_flutter/views/sample/shipment_samples.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_text_elevated_button.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_form_dropdown.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_text_form_field.dart';

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
  final List<Client> _clients = [];
  List<Sample> samples = [];
  int _sampleCount = 0;
  List<String> selectedSamples = [];

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

  Shipment loadCurrentShipment(String shipmentId) {
    var shipements = Provider.of<ShipmentProvider>(context, listen: false)
        .shipments
        .where((shipment) => shipment.id == shipmentId)
        .toList();

    if (shipements.isEmpty) return Shipment(samples: []);

    return shipements.first;
  }

  @override
  Widget build(BuildContext context) {
    bool isNewForm = widget.shipmentData == null;

    Shipment _shipment = widget.shipmentData ?? Shipment(samples: []);

    if (_shipment.id != null) {
      _shipment = loadCurrentShipment(_shipment.id ?? "");
    }

    String _appBarText = isNewForm ? 'Add' : 'Update';
    String _saveButtonText = isNewForm ? 'Save' : 'Update';

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
                      onSaved: (value) {},
                    ),
                    Visibility(
                      visible: !isNewForm,
                      child: CustomTextFormField(
                        keyboardType: TextInputType.number,
                        labelText: "Temperature Destination",
                        initialValue: _shipment.temperatureDestination,
                        onSaved: (value) {
                          if (value != null) {
                            _shipment.temperatureDestination = value;
                          }
                        },
                      ),
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
                            _shipment.samples = selectedSamples;
                            widget.shipmentData == null
                                ? addNewShipment(context, _shipment)
                                : updateShipment(context, _shipment);

                            showNotification(context);
                            Navigator.of(context).pop();
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

  Padding samplesSection(Shipment _shipment) {
    _sampleCount = selectedSamples.length;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextButton(
              onPressed: () {
                Provider.of<ShipmentProvider>(context, listen: false)
                    .addShipment(_shipment)
                    .then((savedShipment) {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => ShipmentSamples(
                        shipment: savedShipment,
                      ),
                    ),
                  );
                });
              },
              child: Text(
                "View Samples",
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

  // void _samplesDialog(
  //     BuildContext context, List<Sample>? samples, Shipment _shipment) async {
  //   if (samples!.isEmpty) {
  //     return showErrorNotification(context, "No samples available, please add");
  //   }

  //   var items = samples
  //       .map((sample) => MultiSelectItem<String?>(
  //           sample.id, sample.clientPatientId ?? "Something"))
  //       .toList();

  //   await showDialog(
  //       context: context,
  //       builder: (context) {
  //         return MultiSelectDialog(
  //           confirmText: const Text("OK"),
  //           cancelText: const Text("CANCEL"),
  //           items: items,
  //           initialValue:
  //               selectedSamples.isEmpty ? _shipment.samples : selectedSamples,
  //           height: MediaQuery.of(context).size.height / 2.5,
  //           searchable: true,
  //           searchHint: "",
  //           onConfirm: (results) {
  //             results as List<String>;
  //             setState(() {
  //               selectedSamples = results;
  //               _sampleCount = results.length;
  //             });
  //           },
  //         );
  //       });
  // }

  // samplesList(List<Sample>? samples, Shipment _shipment) {
  //   if (samples!.isEmpty) return const Text("No samples available yet.");

  //   return Padding(
  //     padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
  //     child: MultiSelectDialogField(
  //       // decoration: BoxDecoration(
  //       //   borderRadius: const BorderRadius.all(Radius.circular(5)),
  //       //   border: Border.all(
  //       //     color: Colors.grey,
  //       //     width: 1.0,
  //       //   ),
  //       // ),
  //       initialValue: _shipment.samples,
  //       items: samples
  //           .map((sample) => MultiSelectItem<String?>(
  //               sample.id, sample.clientPatientId ?? "Something"))
  //           .toList(),
  //       buttonIcon: const Icon(Icons.add, size: 38),
  //       height: MediaQuery.of(context).size.height / 2.5,
  //       searchable: true,
  //       chipDisplay: MultiSelectChipDisplay.none(),
  //       title: const Text("Samples"),
  //       selectedColor: Colors.blue,
  //       onConfirm: (results) {
  //         results as List<String>;
  //         setState(() {
  //           _shipment.samples = results;
  //         });
  //       },
  //       onSaved: (value) {
  //         value as List<String>;
  //         _shipment.samples = value;
  //       },
  //     ),
  //   );
  // }

  _desination(Shipment _shipment) {
    var destination;

    var destinations = ["Hub 1", "Lab 1"];

    var destinationMenus = destinations.map((String sampleType) {
      return DropdownMenuItem<String>(
          value: sampleType, child: Text(sampleType));
    }).toList();

    return CustomFormDropdown(
        items: destinationMenus,
        hint: const Text("Destination"),
        value: destination ?? _shipment.destination,
        onChanged: (value) {
          destination = value.toString();
        },
        onSaved: (value) {
          _shipment.destination = value.toString();
        });
  }

  _selectClientDropdown(Shipment _shipment) {
    var clientMenus;
    setState(() {
      clientMenus = _clients.map((Client client) {
        return DropdownMenuItem<String>(
          value: client.clientId,
          child: Text(client.name ?? "Name unavailable"),
        );
      }).toList();
    });

    return CustomFormDropdown(
      value: _value ?? _shipment.clientId,
      hint: const Text("Please select client"),
      items: clientMenus,
      onSaved: (value) {
        _shipment.clientId = value.toString();
      },
      onChanged: (value) {
        _value = value as Client;
      },
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
    _shipment.status = "Created";
    _shipment.dateCreated = _shipment.dateModified = DateTime.now().toString();
    Provider.of<ShipmentProvider>(context, listen: false)
        .updateShipment(_shipment);
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

  void showErrorNotification(BuildContext context, String message) {
    // we should extract this into common area for forms
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
