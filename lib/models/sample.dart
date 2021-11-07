class Sample {
  String appId = "";
  int? id;
  String clientSampleId = "";
  String clientPatientId = "";
  String labId = "";
  String clientId = "";
  String sampleType = "";
  String testId = "";
  String dateCollected = "";
  String collectedBy = "";
  String status = "";
  String comment = "";
  bool synced = false;
  String dateSynced = "";
  String labReferenceId = "";
  String location = "";
  String result = "";
  String resultReceivedBy = "";
  String shipmentId = "";
  String clientContact = "";
  String temperatureAtHub = "";
  String temperatureAtLab = "";
  bool isModifiedByHub = false;
  bool isModifiedByFacility = false;
  bool isModifiedByLaboratory = false;
  bool isModifiedByCourier = false;
  String createdBy = "";
  String lastModifiedBy = "";
  String createdDate = "";
  String lastModifiedDate = "";
  String patient = "";

  Sample(
      {this.appId = "",
      this.id,
      this.clientSampleId = "",
      this.clientPatientId = "",
      this.labId = "",
      this.clientId = "",
      this.sampleType = "",
      this.testId = "",
      this.dateCollected = "",
      this.collectedBy = "",
      this.status = "",
      this.comment = "",
      this.synced = false,
      this.dateSynced = "",
      this.labReferenceId = "",
      this.location = "",
      this.result = "",
      this.resultReceivedBy = "",
      this.shipmentId = "",
      this.clientContact = "",
      this.temperatureAtHub = "",
      this.temperatureAtLab = "",
      this.isModifiedByHub = false,
      this.isModifiedByFacility = false,
      this.isModifiedByLaboratory = false,
      this.isModifiedByCourier = false,
      this.createdBy = "",
      this.lastModifiedBy = "",
      this.createdDate = "",
      this.lastModifiedDate = "",
      this.patient = ""});

  Sample.fromJson(Map<String, dynamic> json) {
    appId = json['appId'];
    id = json['_id'] ?? json['id'];
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
    temperatureAtHub = json['temperatureAtHub'];
    temperatureAtLab = json['temperatureAtLab'];
    isModifiedByHub = json['isModifiedByHub'] == "true" ? true : false;
    isModifiedByFacility =
        json['isModifiedByFacility'] == "true" ? true : false;
    isModifiedByLaboratory =
        json['isModifiedByLaboratory'] == "true" ? true : false;
    isModifiedByCourier = json['isModifiedByCourier'] == "true" ? true : false;
    createdBy = json['createdBy'];
    lastModifiedBy = json['lastModifiedBy'];
    createdDate = json['createdDate'] ?? "";
    lastModifiedDate = json['lastModifiedDate'];
    patient = json['patient'] ?? "";
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appId'] = appId;
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
    data['temperatureAtHub'] = temperatureAtHub;
    data['temperatureAtLab'] = temperatureAtLab;
    data['isModifiedByHub'] = isModifiedByHub.toString();
    data['isModifiedByFacility'] = isModifiedByFacility.toString();
    data['isModifiedByLaboratory'] = isModifiedByLaboratory.toString();
    data['isModifiedByCourier'] = isModifiedByCourier.toString();
    data['createdBy'] = createdBy;
    data['lastModifiedBy'] = lastModifiedBy;
    data['createdDate'] = createdDate;
    data['lastModifiedDate'] = lastModifiedDate;
    data['patient'] = patient;
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Sample &&
        other.appId == appId &&
        other.id == id &&
        other.clientSampleId == clientSampleId &&
        other.clientPatientId == clientPatientId &&
        other.labId == labId &&
        other.clientId == clientId &&
        other.sampleType == sampleType &&
        other.testId == testId &&
        other.dateCollected == dateCollected &&
        other.collectedBy == collectedBy &&
        other.status == status &&
        other.comment == comment &&
        other.synced == synced &&
        other.dateSynced == dateSynced &&
        other.labReferenceId == labReferenceId &&
        other.location == location &&
        other.result == result &&
        other.resultReceivedBy == resultReceivedBy &&
        other.shipmentId == shipmentId &&
        other.clientContact == clientContact &&
        other.temperatureAtHub == temperatureAtHub &&
        other.temperatureAtLab == temperatureAtLab &&
        other.isModifiedByHub == isModifiedByHub &&
        other.isModifiedByFacility == isModifiedByFacility &&
        other.isModifiedByLaboratory == isModifiedByLaboratory &&
        other.isModifiedByCourier == isModifiedByCourier &&
        other.createdBy == createdBy &&
        other.lastModifiedBy == lastModifiedBy &&
        other.createdDate == createdDate &&
        other.lastModifiedDate == lastModifiedDate &&
        other.patient == patient;
  }

  @override
  int get hashCode {
    return appId.hashCode ^
        id.hashCode ^
        clientSampleId.hashCode ^
        clientPatientId.hashCode ^
        labId.hashCode ^
        clientId.hashCode ^
        sampleType.hashCode ^
        testId.hashCode ^
        dateCollected.hashCode ^
        collectedBy.hashCode ^
        status.hashCode ^
        comment.hashCode ^
        synced.hashCode ^
        dateSynced.hashCode ^
        labReferenceId.hashCode ^
        location.hashCode ^
        result.hashCode ^
        resultReceivedBy.hashCode ^
        shipmentId.hashCode ^
        clientContact.hashCode ^
        temperatureAtHub.hashCode ^
        temperatureAtLab.hashCode ^
        isModifiedByHub.hashCode ^
        isModifiedByFacility.hashCode ^
        isModifiedByLaboratory.hashCode ^
        isModifiedByCourier.hashCode ^
        createdBy.hashCode ^
        lastModifiedBy.hashCode ^
        createdDate.hashCode ^
        lastModifiedDate.hashCode ^
        patient.hashCode;
  }
}
