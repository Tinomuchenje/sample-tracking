import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/consts/constants.dart';
import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:sample_tracking_system_flutter/providers/shipment_provider.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_elevated_button.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_text_form_field.dart';

class AddorUpdateShipmentDialog extends StatelessWidget {
  Shipment? shipmentData;
  AddorUpdateShipmentDialog({Key? key, this.shipmentData}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Shipment _shipment = shipmentData ?? Shipment();
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
                    CustomTextFormField(
                      labelText: "Shipment ID",
                      initialValue: _shipment.Id,
                      onSaved: (value) {
                        if (value != null) _shipment.Id = value;
                      },
                    ),
                    CustomTextFormField(
                      labelText: "Client Id",
                      initialValue: _shipment.clientId,
                      onSaved: (value) {
                        if (value != null) _shipment.clientId = value;
                      },
                    ),
                    CustomTextFormField(
                      labelText: "Samples",
                    ),
                    CustomTextFormField(
                      labelText: "Date Created",
                      initialValue: _shipment.dateCreated,
                      onSaved: (value) {
                        if (value != null) _shipment.dateCreated = value;
                      },
                    ),
                    CustomTextFormField(
                      labelText: "Date Modified",
                      initialValue: _shipment.dateModified,
                      onSaved: (value) {
                        if (value != null) _shipment.dateModified = value;
                      },
                    ),
                    CustomElevatedButton(
                      labelText: "Save Sample",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          shipmentData == null
                              ? addNewShipment(context, _shipment)
                              : addNewShipment(context, _shipment);

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
