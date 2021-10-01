class Shipment {
  String? id;
  String? clientId;
  List<String> samples;
  String? status;
  String? dateCreated;
  String? dateModified;
  String? riderId;
  String? riderName;
  String? destination;
  String? clusterClientId;

  Shipment(
      {this.id,
      this.clientId,
      required this.samples,
      this.status,
      this.dateCreated,
      this.dateModified,
      this.riderId,
      this.riderName,
      this.destination,
      this.clusterClientId});

  Map<String, dynamic> toMap() {
    return {
      'shipment_id': id,
      'client_id': clientId,
      'samples': samples,
      'status': status,
      'created_at': dateCreated,
      'modified_at': dateModified,
      'riderId': riderId,
      'riderName': riderName,
      'destination': destination,
      'clusterClientId': clusterClientId
    };
  }

  @override
  String toString() {
    return 'Shipment{shipment_id: $id, client_id: $clientId, samples: $samples, status: $status, created_at: $dateCreated, modified_at: $dateModified,riderId: $riderId,riderName: $riderName, destination: $destination, clusterClientId: $clusterClientId}';
  }
}
