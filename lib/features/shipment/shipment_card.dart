import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/features/sample/state/samples_provider.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_card.dart';

import 'state/shipment_provider.dart';

class ShipmentSamplesCard extends StatefulWidget {
  final List<Sample> samples;
  const ShipmentSamplesCard({
    Key? key,
    required this.samples,
  }) : super(key: key);

  @override
  State<ShipmentSamplesCard> createState() => _ShipmentSamplesCardState();
}

class _ShipmentSamplesCardState extends State<ShipmentSamplesCard> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemCount: widget.samples.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomCard(
              child: ListTile(
                  onTap: () {},
                  title: Text(widget.samples[index].clientPatientId),
                  subtitle: Row(
                    children: [
                      const Text("Status:"),
                      Text(widget.samples[index].status),
                    ],
                  ),
                  leading: const Icon(
                    Icons.folder,
                    size: 45,
                    color: Colors.blue,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      removedSampleFromShipment(index, context);
                    },
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }

  void removedSampleFromShipment(int index, BuildContext context) {
    //widget.samples.remove(widget.samples[index]);
    Provider.of<ShipmentProvider>(context, listen: false)
        .removeSampleFromDisplayShipment(widget.samples[index]);

    ///
    /// Since we removed the sample on the shipment we need to update the
    /// shipment itself to highligh it is no longer associated to a shipment
    ///
    if (widget.samples[index].shipmentId.isNotEmpty) {
      widget.samples[index].shipmentId = '';
      Provider.of<SamplesProvider>(context, listen: false)
          .addSample(widget.samples[index]);
    }
  }
}
