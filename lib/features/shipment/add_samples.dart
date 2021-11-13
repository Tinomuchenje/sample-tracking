import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/consts/constants.dart';
import 'package:sample_tracking_system_flutter/features/sample/sample_controller.dart';
import 'package:sample_tracking_system_flutter/features/sample/state/samples_provider.dart';
import 'package:sample_tracking_system_flutter/features/shipment/state/shipment_provider.dart';
import 'package:sample_tracking_system_flutter/features/shipment/state/shipment_status.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_banner.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_text_elevated_button.dart';

import 'create_update_shipment.dart';
import 'shipment_card.dart';

class AddSamples extends StatefulWidget {
  const AddSamples({Key? key}) : super(key: key);

  @override
  _AddSamplesState createState() => _AddSamplesState();
}

class _AddSamplesState extends State<AddSamples> {
  Shipment _shipment = Shipment();

  @override
  void initState() {
    setSamplesToDisplay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _shipment = Provider.of<ShipmentProvider>(context, listen: false).shipment;
    setSamplesToDisplay();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Samples"),
        ),
        body: Consumer<ShipmentProvider>(
            builder: (context, shpmentProvider, child) {
          var displaySamples = shpmentProvider.displayShipmentSamples;
          return Column(
            children: [
              ShipmentSamplesCard(samples: displaySamples),
              Visibility(
                visible: isEnabled,
                replacement: const CustomBanner(
                  message: 'Editing disabled for shipments in transit.',
                ),
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 140,
                        child: CustomElevatedButton(
                            displayText: "Confirm",
                            fillcolor: true,
                            press: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Provider.of<ShipmentProvider>(context,
                                      listen: false)
                                  .displayShipmentSamples
                                  .clear();

                              Provider.of<ShipmentProvider>(context,
                                      listen: false)
                                  .shipment = _shipment;
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const CreateUpdateShipment(),
                                  fullscreenDialog: true,
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        width: 140,
                        child: CustomElevatedButton(
                            displayText: "Select Samples",
                            fillcolor: true,
                            press: () {
                              _samplesDialog(context, displaySamples);
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }));
  }

  bool get isEnabled {
    return _shipment.status == createdStatus || _shipment.status.isEmpty;
  }

  void _samplesDialog(BuildContext context, List<Sample> initialSamples) async {
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
            initialValue: initialSamples,
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
      _shipment.samples = [...currentSampleIds];
    });

    await setSamplesToDisplay();
  }

  Future setSamplesToDisplay() async {
    await SampleController.getSamplesFromIds(_shipment.samples).then((value) {
      Provider.of<ShipmentProvider>(context, listen: false)
          .displayShipmentSamples = value;
    });
  }
}
