import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/features/sample/sample_controller.dart';
import 'package:sample_tracking_system_flutter/features/sample/state/samples_provider.dart';
import 'package:sample_tracking_system_flutter/features/shipment/state/shipment_provider.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_text_elevated_button.dart';

import 'shipment_card.dart';

class AddSamples extends StatefulWidget {
  Shipment shipment;
  AddSamples({Key? key, required this.shipment}) : super(key: key);

  @override
  _AddSamplesState createState() => _AddSamplesState();
}

class _AddSamplesState extends State<AddSamples> {
  List<Sample> _displayedSamples = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Samples"),
      ),
      body: Column(
        children: [
          CustomElevatedButton(
              displayText: "Add Samples",
              fillcolor: true,
              press: () {
                // pop dialog
                // set values on sipment.samples
                _samplesDialog(context);
              }),
          ShipmentSamplesCard(samples: [])
        ],
      ),
    );
  }

  void _samplesDialog(BuildContext context) async {
    var samples =
        Provider.of<SamplesProvider>(context, listen: false).unshipedSamples;
    var items = samples
        .map((sample) => MultiSelectItem<Sample>(
            sample, sample.clientSampleId + ' - ' + sample.clientPatientId))
        .toList();

    await showDialog(
        context: context,
        builder: (context) {
          return MultiSelectDialog(
            confirmText: const Text("OK"),
            cancelText: const Text("CANCEL"),
            items: items,
            initialValue: widget.shipment.samples,
            height: MediaQuery.of(context).size.height / 2.5,
            searchable: true,
            searchHint: "",
            onConfirm: (results) {
              List<Sample> selectedSamples =
                  List<Sample>.from(results).toList();

              _addSamples(selectedSamples);
            },
          );
        });
  }

  void _addSamples(List<Sample> selectedSamples) async {
    List<String> currentSampleIds = [];

    for (Sample sample in selectedSamples) {
      currentSampleIds.add(sample.appId);
    }

    setState(() {
      print(widget.shipment.samples.toString());
      widget.shipment.samples = [...currentSampleIds];
      print(widget.shipment.samples.toString());
    });

    await SampleController.getSamplesFromIds(widget.shipment.samples)
        .then((value) {
      Provider.of<ShipmentProvider>(context).displayShipmentSamples = value;
    });
  }
}
