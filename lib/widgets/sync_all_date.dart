
import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/features/patient/patient_controller.dart';
import 'package:sample_tracking_system_flutter/features/sample/sample_controller.dart';
import 'package:sample_tracking_system_flutter/features/shipment/shipment_controller.dart';

class SyncAll extends StatelessWidget {
  const SyncAll({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
       // color: Colors.grey,
        onPressed: () async {
          // Patients syncing
          await PatientController().addPatientsOnline().then((value) async {
            await PatientController().getOnlinePatients();
          });

          // Samples syncing
          await SampleController().addSamplesOnline().then((value) async {
            await SampleController().getOnlineSamples();

            // Shipment syncing
            await ShipmentController().addShipmentsOnline().then((value) async {
              await ShipmentController().getOnlineShipments();
            });
          });
        },
        icon: const Icon(
          Icons.sync,
          size: 29,
        ));
  }
}
