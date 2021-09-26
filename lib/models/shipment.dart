import 'package:sample_tracking_system_flutter/models/sample.dart';

class Shipment {
  String? id;
  String? clientId;
  List<Sample> samples;
  String? status;
  String? dateCreated;
  String? dateModified;

  Shipment(
      {this.id,
      this.clientId,
      required this.samples,
      this.status,
      this.dateCreated,
      this.dateModified});

  Map<String, dynamic> toMap() {
    return {
      'shipment_id': id,
      'client_id': clientId,
      'samples': samples,
      'status': status,
      'created_at': dateCreated.toString(),
      'modified_at': dateModified.toString(),
    };
  }

  @override
  String toString() {
    return 'Shipment{shipment_id: $id, client_id: $clientId, samples: $samples, status: $status, created_at: $dateCreated, modified_at: $dateModified}';
  }
}
