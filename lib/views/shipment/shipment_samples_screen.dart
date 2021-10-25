import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:sample_tracking_system_flutter/views/sample/state/samples_provider.dart';
import 'package:sample_tracking_system_flutter/views/sample/sample_controller.dart';
import 'package:sample_tracking_system_flutter/views/shipment/shipment_card.dart';
import 'package:sample_tracking_system_flutter/views/shipment/state/status.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_text_elevated_button.dart';
import 'package:sample_tracking_system_flutter/views/widgets/notification_service.dart';

import 'add_shipment_screen.dart';

class ShipmentSamples extends StatefulWidget {
  final Shipment? shipment;
  const ShipmentSamples({Key? key, this.shipment}) : super(key: key);

  @override
  _ShipmentSamplesState createState() => _ShipmentSamplesState();
}

class _ShipmentSamplesState extends State<ShipmentSamples> {
  List<String> _displayedSamples = [];
  Shipment? currentShipment;

  @override
  Widget build(BuildContext context) {
    currentShipment = widget.shipment;

    return Scaffold(
      appBar: AppBar(title: const Text("Shipment Samples")),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Visibility(
            visible: currentShipment!.status != publishedStatus,
            child: Consumer<SamplesProvider>(
                builder: (context, sampleProvider, child) {
              return addSamples(context, sampleProvider.unshipedSamples);
            }),
          ),
          const SizedBox(height: 20),
          Expanded(child: shipmentExistingSamplesCards()),
        ],
      ),
    );
  }

  Widget addSamples(BuildContext context, List<Sample> samples) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: 50,
          width: 150,
          child: CustomElevatedButton(
            displayText: "Save samples",
            fillcolor: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => AddorUpdateShipmentDialog(
                    shipmentData: currentShipment,
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 50,
          width: 150,
          child: CustomElevatedButton(
            displayText: "Add sample/s",
            fillcolor: true,
            press: () {
              _samplesDialog(context, samples);
            },
          ),
        ),
      ],
    );
  }

  Widget shipmentExistingSamplesCards() {
    _displayedSamples = currentShipment!.samples.toList();

    if (_displayedSamples.isEmpty) {
      return const Text("No samples available");
    } // Happy here

    return FutureBuilder(
      future: SampleController.getSamplesFromIds(_displayedSamples),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          //print('project snapshot data is: ${projectSnap.data}');
          return const Text("Loading");
        }
        var samples = snapshot.data as List<Sample>;

        if (samples.isEmpty) const Center(child: Text("No samples available"));

        return ShipmentSamplesCard(samples: samples);
      },
    );
  }

  void _samplesDialog(BuildContext context, List<Sample>? samples) async {
    List<Sample> selectedSamples = [];
    if (samples!.isEmpty) {
      return NotificationService.warning(
          context, 'No samples available, please add');
    }

    var items = samples
        .map(
            (sample) => MultiSelectItem<Sample>(sample, sample.clientPatientId))
        .toList();

    await showDialog(
        context: context,
        builder: (context) {
          return MultiSelectDialog(
            confirmText: const Text("OK"),
            cancelText: const Text("CANCEL"),
            items: items,
            initialValue: const [],
            height: MediaQuery.of(context).size.height / 2.5,
            searchable: true,
            searchHint: "",
            onConfirm: (results) {
              selectedSamples = List<Sample>.from(results).toList();
              updateSample(selectedSamples, context);
            },
          );
        });
  }

  void updateSample(List<Sample> selectedSamples, BuildContext context) {
    var currentSampleIds = currentShipment!.samples.toList();

    for (Sample sample in selectedSamples) {
      currentSampleIds.add(sample.appId);
    }

    setState(() {
      currentShipment!.samples = currentSampleIds;
    });
  }
}
