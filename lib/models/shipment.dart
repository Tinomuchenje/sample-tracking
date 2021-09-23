import 'dart:ffi';

const String tableShipment = "shipment";

class ShipmentFileds {
  static final List<String> values = [
    shipment_id,
    client_id,
    samples,
    status,
    created_at,
    modified_at
  ];
  static final String shipment_id = "shipment_id";
  static final String client_id = "client_id";
  static final String samples = "samples";
  static final String status = "status";
  static final String created_at = "created_at";
  static final String modified_at = "modified_at";
}

class Shipment {
  final String shipment_id;
  final String client_id;
  final Array samples;
  final String status;
  final DateTime created_at;
  final DateTime modified_at;

  Shipment(this.shipment_id, this.client_id, this.samples, this.status,
      this.created_at, this.modified_at);

  Map<String, dynamic> toMap() {
    return {
      'shipment_id': shipment_id,
      'client_id': client_id,
      'samples': samples,
      'status': status,
      'created_at': created_at.toString(),
      'modified_at': modified_at.toString(),
    };
  }

  @override
  String toString() {
    return 'Shipment{shipment_id: $shipment_id, client_id: $client_id, samples: $samples, status: $status, created_at: $created_at, modified_at: $modified_at}';
  }
}
