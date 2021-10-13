// ignore_for_file: unnecessary_new

import 'audit_log.dart';

class Sample {
  String? id;
  String? clientSampleId;
  String? clientPatientId;
  String? labId;
  String? clientId;
  String? sampleType;
  String? testId;
  String? dateCollected;
  String? collectedBy;
  String? status;
  String? comment;
  bool? synced;
  String? dateSynced;
  String? labReferenceId;
  String? location;
  String? result;
  String? resultReceivedBy;
  String? shipmentId;
  String? clientContact;
  String? dateCreated;
  String? dateModified;
  String? temperatureAtHub;
  String? temperatureAtLab;
  AuditLog? auditLogAuditLog;

  Sample(
      {this.id,
      this.clientSampleId,
      this.clientPatientId,
      this.labId,
      this.clientId,
      this.sampleType,
      this.testId,
      this.dateCollected,
      this.collectedBy,
      this.status,
      this.comment,
      this.synced,
      this.dateSynced,
      this.labReferenceId,
      this.location,
      this.result,
      this.resultReceivedBy,
      this.shipmentId,
      this.clientContact,
      this.dateCreated,
      this.dateModified,
      this.temperatureAtHub,
      this.temperatureAtLab,
      this.auditLogAuditLog});

  Sample.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientSampleId = json['clientSampleId'];
    clientPatientId = json['clientPatientId'];
    labId = json['labId'];
    clientId = json['clientId'];
    sampleType = json['sampleType'];
    testId = json['testId'];
    dateCollected = json['dateCollected'];
    collectedBy = json['collectedBy'];
    status = json['status'];
    comment = json['comment'];
    synced = json['synced'];
    dateSynced = json['dateSynced'];
    labReferenceId = json['labReferenceId'];
    location = json['location'];
    result = json['result'];
    resultReceivedBy = json['resultReceivedBy'];
    shipmentId = json['shipmentId'];
    clientContact = json['clientContact'];
    dateCreated = json['dateCreated'];
    dateModified = json['dateModified'];
    temperatureAtHub = json['temperatureAtHub'];
    temperatureAtLab = json['temperatureAtLab'];
    auditLogAuditLog = json['auditLog'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['clientSampleId'] = clientSampleId;
    data['clientPatientId'] = clientPatientId;
    data['labId'] = labId;
    data['clientId'] = clientId;
    data['sampleType'] = sampleType;
    data['testId'] = testId;
    data['dateCollected'] = dateCollected;
    data['collectedBy'] = collectedBy;
    data['status'] = status;
    data['comment'] = comment;
    data['synced'] = synced;
    data['dateSynced'] = dateSynced;
    data['labReferenceId'] = labReferenceId;
    data['location'] = location;
    data['result'] = result;
    data['resultReceivedBy'] = resultReceivedBy;
    data['shipmentId'] = shipmentId;
    data['clientContact'] = clientContact;
    data['dateCreated'] = dateCreated;
    data['dateModified'] = dateModified;
    data['temperatureAtHub'] = temperatureAtHub;
    data['temperatureAtLab'] = temperatureAtLab;
    data['AuditLog? auditLog'] = auditLogAuditLog!.toJson();
    return data;
  }
}
