// ignore_for_file: unnecessary_new

class Sample {
  String? id;
  String? appId;
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
  String? temperatureAtHub;
  String? temperatureAtLab;
  bool? isModifiedByHub;
  bool? isModifiedByFacility;
  bool? isModifiedByLaboratory;
  bool? isModifiedByCourrier;
  String? createdBy;
  String? lastModifiedBy;
  String? createdDate;
  String? lastModifiedDate;


  Sample(
      {this.id,
        this.appId,
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
      this.temperatureAtHub,
      this.temperatureAtLab,
      this.isModifiedByHub,
      this.isModifiedByFacility,
      this.isModifiedByLaboratory,
      this.isModifiedByCourrier,
      this.createdBy,
      this.lastModifiedBy,
      this.createdDate,
      this.lastModifiedDate});

  Sample.fromJson(Map<String, dynamic> json) {
    id=json['id'];
    appId = json['appId'];
    clientSampleId=json['clientSampleId'];
    clientPatientId=json['clientPatientId'];
    labId=json['labId'];
    clientId=json['clientId'];
    sampleType=json['sampleType'];
    testId=json['testId'];
    dateCollected=json['dateCollected'];
    collectedBy=json['collectedBy'];
    status=json['status'];
    comment=json['comment'];
    synced=json['synced'];
    dateSynced=json['dateSynced'];
    labReferenceId=json['labReferenceId'];
    location=json['location'];
    result=json['result'];
    resultReceivedBy=json['resultReceivedBy'];
    shipmentId=json['shipmentId'];
    clientContact=json['clientContact'];
    temperatureAtHub=json['temperatureAtHub'];
    temperatureAtLab=json['temperatureAtLab'];
    isModifiedByHub=json['isModifiedByHub'];
    isModifiedByFacility=json['isModifiedByFacility'];
    isModifiedByLaboratory=json['isModifiedByLaboratory'];
    isModifiedByCourrier=json['isModifiedByCourrier'];
    createdBy=json['createdBy'];
    lastModifiedBy=json['lastModifiedBy'];
    createdDate=json['createdDate'];
    lastModifiedDate=json['lastModifiedDate'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['appId'] = appId;
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
    data['temperatureAtHub'] = temperatureAtHub;
    data['temperatureAtLab'] = temperatureAtLab;
    data['isModifiedByHub'] = isModifiedByHub;
    data['isModifiedByFacility'] = isModifiedByFacility;
    data['isModifiedByLaboratory'] = isModifiedByLaboratory;
    data['isModifiedByCourrier'] = isModifiedByCourrier;
    data['createdBy'] = createdBy;
    data['lastModifiedBy'] = lastModifiedBy;
    data['createdDate'] = createdDate;
    data['lastModifiedDate'] = lastModifiedDate;
    return data;
  }
}
