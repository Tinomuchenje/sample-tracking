import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/models/shipment.dart';
import 'package:sample_tracking_system_flutter/providers/samples_provider.dart';
import 'package:sample_tracking_system_flutter/providers/shipment_provider.dart';
import 'package:sample_tracking_system_flutter/views/sample/sample_controller.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_card.dart';

class ShipmentSamples extends StatefulWidget {
  final Shipment? shipment;
  const ShipmentSamples({Key? key, this.shipment}) : super(key: key);

  @override
  _ShipmentSamplesState createState() => _ShipmentSamplesState();
}

class _ShipmentSamplesState extends State<ShipmentSamples> {
  List<String> _displayedSamples = [];
  String? currentShipmentId;

  @override
  Widget build(BuildContext context) {
    currentShipmentId = widget.shipment!.id ?? "";

    return Scaffold(
      appBar: AppBar(title: const Text("Shipment Samples")),
      body: shipmentExistingSamplesCards(),
      floatingActionButton:
          Consumer<SamplesProvider>(builder: (context, sampleProvider, child) {
        return addSamples(context, sampleProvider.unshipedSamples);
      }),
    );
  }

  FloatingActionButton addSamples(BuildContext context, List<Sample> samples) {
    return FloatingActionButton.extended(
        onPressed: () {
          _samplesDialog(context, samples);
        },
        label: const Text('Add samples'),
        icon: const Icon(
          Icons.add,
          size: 35.0,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue);
  }

  Widget shipmentExistingSamplesCards() {
    Shipment shipmentx = loadCurrentShipment();
    _displayedSamples = shipmentx.samples.toList();

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
        if (samples.isEmpty) const Text("No samples available");
        return ShipmentSamplesCard(samples: samples);
      },
    );
  }

  Shipment loadCurrentShipment() {
    var shipements = Provider.of<ShipmentProvider>(context, listen: false)
        .shipments
        .where((shipment) => shipment.id == currentShipmentId)
        .toList();

    if (shipements.isEmpty) return Shipment(samples: []);

    return shipements.first;
  }

  void _samplesDialog(BuildContext context, List<Sample>? samples) async {
    List<Sample> selectedSamples = [];
    if (samples!.isEmpty) {
      return;
      // showErrorNotification(context, "No samples available, please add");
    }

    var items = samples
        .map((sample) => MultiSelectItem<Sample>(
            sample, sample.clientPatientId ?? "Something"))
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
    Shipment shipmentx = loadCurrentShipment();
    var currentSamples = shipmentx.samples.toList();

    for (Sample sample in selectedSamples) {
      if (sample.appId == null) continue;
      currentSamples.add(sample.appId ?? "");
    }
    
    setState(() {
      shipmentx.samples = currentSamples;
    });

    Provider.of<ShipmentProvider>(context, listen: false)
        .saveOrUpdate(shipmentx);
  }
}

class ShipmentSamplesCard extends StatelessWidget {
  const ShipmentSamplesCard({
    Key? key,
    required this.samples,
  }) : super(key: key);

  final List<Sample> samples;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: samples.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomCard(
            child: ListTile(
                onTap: () {},
                title: Text(samples[index].clientPatientId ?? ""),
                subtitle: Row(
                  children: const [Text("Status:"), Text("Ready")],
                ),
                leading: const Icon(
                  Icons.folder,
                  size: 45,
                  color: Colors.blue,
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                )),
          ),
        );
      },
    );
  }
}
