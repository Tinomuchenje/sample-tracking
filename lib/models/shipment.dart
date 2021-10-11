import 'package:sample_tracking_system_flutter/models/audit_log.dart';

class Shipment {
  String? id;
  String? description;
  String? clientId;
  late List<String> samples;
  String? status;
  String? dateCreated;
  String? dateModified;
  String? riderId;
  String? riderName;
  String? destination;
  String? clusterClientId;
  String? temperatureOrigin;
  String? temperatureDestination;
  AuditLog? auditLog;

  Shipment({
    this.id,
    this.description,
    this.clientId,
    required this.samples,
    this.status,
    this.dateCreated,
    this.dateModified,
    this.riderId,
    this.riderName,
    this.destination,
    this.clusterClientId,
    this.temperatureOrigin,
    this.temperatureDestination,
    this.auditLog,
  });

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
      'clusterClientId': clusterClientId,
      'temperatureOrigin': temperatureOrigin,
      'temperatureDestination': temperatureDestination,
      'auditLog': auditLog
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['clientId'] = clientId;
    data['samples'] = samples;
    data['status'] = status;
    data['dateCreated'] = dateCreated;
    data['dateModified'] = dateModified;
    data['riderId'] = riderId;
    data['riderName'] = riderName;
    data['destination'] = destination;
    data['clusterClientId'] = clusterClientId;
    data['temperatureOrigin'] = temperatureOrigin;
    data['temperatureDestination'] = temperatureDestination;
    data['auditLog'] = auditLog;
    return data;
  }

  Shipment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    clientId = json['clientId'];
    samples = json['samples'].cast<String>();
    status = json['status'];
    dateCreated = json['dateCreated'];
    dateModified = json['dateModified'];
    riderId = json['riderId'];
    riderName = json['riderName'];
    destination = json['destination'];
    clusterClientId = json['clusterClientId'];
    temperatureOrigin = json['temperatureOrigin'];
    temperatureDestination = json['temperatureDestination'];
    auditLog = json['auditLog'];
  }

  @override
  String toString() {
    return 'Shipment{shipment_id: $id, client_id: $clientId, samples: $samples, status: $status, created_at: $dateCreated, modified_at: $dateModified,riderId: $riderId,riderName: $riderName, destination: $destination, clusterClientId: $clusterClientId}';
  }
}
