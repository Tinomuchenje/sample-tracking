import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample_tracking_system_flutter/consts/constants.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_form_dropdown.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_text_elevated_button.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_text_form_field.dart';

class CreateUpdateShipment extends StatefulWidget {
  const CreateUpdateShipment({Key? key}) : super(key: key);

  @override
  _CreateUpdateShipmentState createState() => _CreateUpdateShipmentState();
}

class _CreateUpdateShipmentState extends State<CreateUpdateShipment> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                    CustomTextFormField(
                      labelText: 'Label',
                      enabled: false,
                      onSaved: (value) {},
                    ),
                    TextButton(
                        child: Text('Add Samples',
                            style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                              fontSize: 15.0,
                            ))),
                        onPressed: () {}),
                    _desination(),
                    CustomTextFormField(
                      enabled: true,
                      keyboardType: TextInputType.number,
                      labelText: "Temperature Origin",
                      //initialValue: _shipment.temperatureOrigin,
                      onSaved: (value) {
                        if (value != null) {
                          //_shipment.temperatureOrigin = value;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 150,
                            child: CustomElevatedButton(
                              displayText: 'Save',
                              fillcolor: false,
                              press: () {
                                // just saves to local
                                // should not save without samples
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
                                // just publish
                                // should not save without samples
                              },
                            ),
                          )
                        ])
                  ],
                )),
          ),
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
        value: null,
        onChanged: (value) {},
        onSaved: (value) {});
  }
}
