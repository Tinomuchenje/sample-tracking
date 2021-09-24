import 'package:sample_tracking_system_flutter/models/sample.dart';

class Shipment {
  String? shipmentId;
  String? clientId;
  List<Sample>? samples;
  String? status;
  DateTime? dateCreated;
  DateTime? dateModified;

  Shipment(
      {this.shipmentId,
      this.clientId,
      this.samples,
      this.status,
      this.dateCreated,
      this.dateModified});

  Map<String, dynamic> toMap() {
    return {
      'shipment_id': shipmentId,
      'client_id': clientId,
      'samples': samples,
      'status': status,
      'created_at': dateCreated.toString(),
      'modified_at': dateModified.toString(),
    };
  }

  @override
  String toString() {
    return 'Shipment{shipment_id: $shipmentId, client_id: $clientId, samples: $samples, status: $status, created_at: $dateCreated, modified_at: $dateModified}';
  }
}
