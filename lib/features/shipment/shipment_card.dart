import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_card.dart';

class ShipmentSamplesCard extends StatelessWidget {
  const ShipmentSamplesCard({
    Key? key,
    required this.samples,
  }) : super(key: key);

  final List<Sample> samples;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemCount: samples.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomCard(
              child: ListTile(
                  onTap: () {},
                  title: Text(samples[index].clientPatientId),
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
      ),
    );
  }
}
