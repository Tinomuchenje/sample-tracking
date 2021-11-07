import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:sample_tracking_system_flutter/consts/constants.dart';
import 'package:sample_tracking_system_flutter/features/home/home_page.dart';
import 'package:sample_tracking_system_flutter/features/shipment/shipment_samples_screen.dart';
import 'package:sample_tracking_system_flutter/features/shipment/state/shipment_provider.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:sample_tracking_system_flutter/utils/date_service.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_banner.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_form_dropdown.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_text_elevated_button.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_text_form_field.dart';
import 'package:sample_tracking_system_flutter/widgets/notification_service.dart';

import 'state/shipment_status.dart';

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

  List<Sample> samples = [];
  int _sampleCount = 0;
  List<String> selectedSamples = [];
  bool isNewForm = false;
  String? shipmentDescription;

  @override
  Widget build(BuildContext context) {
    String _appBarText = '';
    String _saveButtonText = 'Save';
    Shipment _shipment = widget.shipmentData ?? Shipment();

    if (widget.shipmentData == null || widget.shipmentData!.appId.isEmpty) {
      isNewForm = true;
    }

    if (_shipment.status.isEmpty) {
      _appBarText = 'Add';
    }

    if (!isNewForm && _shipment.status == createdStatus) {
      _appBarText = _saveButtonText = 'Update';
    }

    if (widget.shipmentData != null) {
      _sampleCount = widget.shipmentData!.samples.length;
    }

    return Scaffold(
        appBar: AppBar(
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
                      enabled: false,
                      labelText: "Shipment Label",
                      initialValue: _shipment.description,
                      controller: shipmentDescription,
                      onSaved: (value) {
                        if (value != null) _shipment.description = value;
                      },
                    ),
                    samplesSection(_shipment),
                    _desination(_shipment),
                    CustomTextFormField(
                      enabled: _shipment.status != publishedStatus,
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
                      child: CustomTextFormField(
                          labelText: "Creater",
                          initialValue: "Admin",
                          enabled: false),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: _shipment.status == createdStatus ||
                          _shipment.status.isEmpty,
                      replacement: const CustomBanner(
                        message: 'Editing disabled for shipments in transit.',
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 150,
                            child: CustomElevatedButton(
                              displayText: _saveButtonText,
                              fillcolor: false,
                              press: () {
                                if (_shipment.samples.length < 1) {
                                  NotificationService.error(
                                      context, 'Shipment must have a sample.');
                                  return;
                                }

                                if (_shipment.status != publishedStatus) {
                                  _shipment.status = createdStatus;
                                  saveShipment(context, _shipment);
                                } else {
                                  preventEditingPublishedMessage(context);
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 150,
                            child: CustomElevatedButton(
                              displayText: _saveButtonText + " & Publish",
                              fillcolor: true,
                              press: () {
                                if (_shipment.samples.length < 1) {
                                  NotificationService.error(
                                      context, 'Shipment must  a sample.');
                                  return;
                                }

                                if (_shipment.status != publishedStatus) {
                                  _shipment.status = publishedStatus;
                                  saveShipment(context, _shipment);
                                } else {
                                  preventEditingPublishedMessage(context);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void preventEditingPublishedMessage(BuildContext context) {
    NotificationService.warning(context, "Cannot edit published shipment!");
  }

  void saveShipment(BuildContext context, Shipment _shipment) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Provider.of<ShipmentProvider>(context, listen: false)
          .addUpdateShipment(_shipment);

      NotificationService.success(context, "Saved successfully");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => HomePage(
            pageIndex: 3,
          ),
        ),
      );
    }
  }

  _desination(Shipment _shipment) {
    List<String> destinations = ['Hub 1', 'Lab 1'];

    var destinationMenus = destinations.map((String sampleType) {
      return DropdownMenuItem<String>(
          value: sampleType, child: Text(sampleType));
    }).toList();

    return CustomFormDropdown(
        items: destinationMenus,
        labelText: "Destination",
        value: _shipment.destination.isEmpty || _shipment.destination == 'null'
            ? null
            : _shipment.destination,
        onChanged: (value) {
          if (_shipment.status == publishedStatus) {
            preventEditingPublishedMessage(context);
          } else {
            setState(() {
              _shipment.destination = value.toString();
              _shipment.description = shipmentDescription =
                  _shipment.destination +
                      ' ' +
                      DateService.convertToIsoString(DateTime.now());
            });
          }
        },
        onSaved: (value) {
          _shipment.destination = value.toString();
        });
  }

  Padding samplesSection(Shipment _shipment) {
    _sampleCount = _shipment.samples.length;
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
