import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:sample_tracking_system_flutter/features/sample/state/samples_provider.dart';
import 'package:sample_tracking_system_flutter/features/sample/sample_controller.dart';
import 'package:sample_tracking_system_flutter/features/shipment/shipment_card.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_banner.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_text_elevated_button.dart';
import 'package:sample_tracking_system_flutter/widgets/notification_service.dart';

import 'add_shipment_screen.dart';
import 'state/shipment_provider.dart';
import 'state/shipment_status.dart';

class ShipmentSamples extends StatefulWidget {
  final Shipment? shipment;
  const ShipmentSamples({Key? key, this.shipment}) : super(key: key);

  @override
  _ShipmentSamplesState createState() => _ShipmentSamplesState();
}

class _ShipmentSamplesState extends State<ShipmentSamples> {
  List<Sample> _selectedSamples = [];
  Shipment? currentShipment;

  @override
  Widget build(BuildContext context) {
    currentShipment = widget.shipment;
    setShipmentSamples(context);

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
          Consumer<ShipmentProvider>(
              builder: (context, shipmentProvider, child) {
            return shipmentExistingSamplesCards(
                shipmentProvider.displayShipmentSamples);
          }),
        ],
      ),
    );
  }

  void setShipmentSamples(BuildContext context) {
    Provider.of<ShipmentProvider>(context, listen: false).displayShipmentSamples =
        currentShipment!.samples;
  }

  Widget addSamples(BuildContext context, List<Sample> samples) {
    return Visibility(
      visible: widget.shipment!.status.isEmpty ||
          widget.shipment!.status == createdStatus,
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
              displayText: "Save samples",
              fillcolor: false,
              press: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        AddorUpdateShipmentDialog(
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
      ),
    );
  }

  Widget shipmentExistingSamplesCards(List<dynamic> displayedSamples) {
    if (displayedSamples.isEmpty) {
      return const Text("No samples available");
    }

    return FutureBuilder(
      future: SampleController.getSamplesFromIds(displayedSamples),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Text("Loading");
        }
        var samples = snapshot.data as List<Sample>;

        if (samples.isEmpty) const Center(child: Text("No samples available"));

        return ShipmentSamplesCard(samples: samples);
      },
    );
  }

  void _samplesDialog(BuildContext context, List<Sample>? samples) async {
    if (samples!.isEmpty) {
      return NotificationService.warning(
          context, 'No samples available, please add');
    }

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
            initialValue: _selectedSamples,
            height: MediaQuery.of(context).size.height / 2.5,
            searchable: true,
            searchHint: "",
            onConfirm: (results) {
              _selectedSamples = List<Sample>.from(results).toList();
              updateSample(_selectedSamples, context);
            },
          );
        });
  }

  void updateSample(List<Sample> selectedSamples, BuildContext context) {
    var currentSampleIds = []; // [...currentShipment!.samples];

    for (Sample sample in selectedSamples) {
      currentSampleIds.add(sample.appId);
    }
    //  currentSampleIds.toSet().toList();

    setState(() {
      currentShipment!.samples = currentSampleIds;
    });

    setShipmentSamples(context);
  }
}
