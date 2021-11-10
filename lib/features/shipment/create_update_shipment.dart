import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/consts/constants.dart';
import 'package:sample_tracking_system_flutter/features/home/home_page.dart';
import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:sample_tracking_system_flutter/utils/date_service.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_banner.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_form_dropdown.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_text_elevated_button.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_text_form_field.dart';
import 'package:sample_tracking_system_flutter/widgets/notification_service.dart';

import 'add_samples.dart';
import 'state/shipment_provider.dart';
import 'state/shipment_status.dart';

class CreateUpdateShipment extends StatefulWidget {
  Shipment shipment;
  CreateUpdateShipment({Key? key, required this.shipment}) : super(key: key);

  @override
  _CreateUpdateShipmentState createState() => _CreateUpdateShipmentState();
}

class _CreateUpdateShipmentState extends State<CreateUpdateShipment> {
  final _formKey = GlobalKey<FormState>();
  Shipment _shipment = Shipment();
  int _sampleCount = 0;

  @override
  void initState() {
    _shipment = widget.shipment;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _sampleCount = _shipment.samples.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Create Shipment')),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _desination(),
                    CustomTextFormField(
                      labelText: 'Description',
                      enabled: false,
                      controller: _shipment.description,
                    ),
                    CustomTextFormField(
                      enabled: isEnabled,
                      keyboardType: TextInputType.number,
                      labelText: "Temperature Origin",
                      controller: _shipment.temperatureOrigin,
                      onChanged: (value) {
                        if (value != null) _shipment.temperatureOrigin = value;
                      },
                    ),
                    Row(
                      children: [
                        TextButton(
                            child: Text('View Samples',
                                style: GoogleFonts.openSans(
                                    textStyle: const TextStyle(
                                  fontSize: 15.0,
                                ))),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) => AddSamples(
                                    shipment: _shipment,
                                  ),
                                  fullscreenDialog: true,
                                ),
                              );
                            }),
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
                    const SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: isEnabled,
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
                                displayText: 'Save',
                                fillcolor: false,
                                press: () {
                                  _shipment.status = createdStatus;
                                  _saveShipments();
                                },
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: 150,
                              child: CustomElevatedButton(
                                displayText: 'Publish',
                                fillcolor: true,
                                press: () {
                                  _shipment.status = publishedStatus;
                                  _saveShipments();
                                },
                              ),
                            )
                          ]),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }

  bool get isEnabled {
    return _shipment.status == createdStatus || _shipment.status.isEmpty;
  }

  void _saveShipments() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    if (_shipment.samples.length < 1) {
      NotificationService.error(context, 'Shipment must have a sample.');
      return;
    }
    Provider.of<ShipmentProvider>(context, listen: false)
        .addUpdateShipment(_shipment);

    NotificationService.success(context, "Saved successfully");
    _navigateToHome();
  }

  _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => HomePage(
          pageIndex: 3,
        ),
      ),
    );
  }

  _desination() {
    List<String> destinations = ['Hub 1', 'Lab 1'];

    var destinationMenus = destinations.map((String sampleType) {
      return DropdownMenuItem<String>(
          value: sampleType, child: Text(sampleType));
    }).toList();

    return CustomFormDropdown(
        items: destinationMenus,
        labelText: "Destination",
        value: _shipment.destination.isNotEmpty ? _shipment.destination : null,
        onChanged: !isEnabled
            ? null
            : (value) {
                setState(() {
                  _shipment.destination = value.toString();
                  _shipment.description = _shipment.destination +
                      ' ' +
                      DateService.convertToIsoString(DateTime.now());
                });
              },
        onSaved: (value) {});
  }
}
