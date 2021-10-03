class Shipment {
  String? id;
  String? clientId;
  late List<String> samples;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['clientId'] = clientId;
    data['samples'] = samples;
    data['status'] = status;
    data['dateCreated'] = dateCreated;
    data['dateModified'] = dateModified;
    data['riderId'] = riderId;
    data['riderName'] = riderName;
    data['destination'] = destination;
    data['clusterClientId'] = clusterClientId;
    return data;
  }

  Shipment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['clientId'];
    samples = json['samples'].cast<String>();
    status = json['status'];
    dateCreated = json['dateCreated'];
    dateModified = json['dateModified'];
    riderId = json['riderId'];
    riderName = json['riderName'];
    destination = json['destination'];
    clusterClientId = json['clusterClientId'];
  }

  @override
  String toString() {
    return 'Shipment{shipment_id: $id, client_id: $clientId, samples: $samples, status: $status, created_at: $dateCreated, modified_at: $dateModified,riderId: $riderId,riderName: $riderName, destination: $destination, clusterClientId: $clusterClientId}';
  }
}
