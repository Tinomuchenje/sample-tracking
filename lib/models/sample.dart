class Sample {
  String? sampleRequestId;
  String? clientSampleId;
  String? patientId;
  String? labId;
  String? clientId;
  String? sampleId;
  String? testId;
  String? dateCollected;
  String? status;
  bool? synced;
  String? dateSynced;
  String? labReferenceId;
  String? location;
  String? result;
  String? shipmentId;
  String? clientContact;
  String? dateCreated;
  String? dateModified;

  Sample(
      {this.sampleRequestId,
      this.clientSampleId,
      this.patientId,
      this.labId,
      this.clientId,
      this.sampleId,
      this.testId,
      this.dateCollected,
      this.status,
      this.synced,
      this.labReferenceId,
      this.result,
      this.shipmentId,
      this.clientContact,
      this.dateCreated,
      this.dateModified,
      this.dateSynced,
      this.location});

  Map<String, dynamic> toMap() {
    return {
      'sample_request_id': sampleRequestId,
      'client_sample_id': clientSampleId,
      'patient_id': patientId,
      'lab_id': labId,
      'client_id': clientId,
      'sample_id': sampleId,
      'test_id': testId,
      'date_collected': dateCollected.toString(),
      'status': status,
      'synced': synced,
      'synced_at': dateSynced.toString(),
      'lab_reference_id': labReferenceId,
      'location': location,
      'result': result,
      'shipment_id': shipmentId,
      'client_contact': clientContact,
      'created_at': dateCreated.toString(),
      'modified_at': dateModified.toString(),
    };
  }

  @override
  String toString() {
    return 'Sample{sample_request_id: $sampleRequestId, client_sample_id: $clientSampleId, patient_id: $patientId, lab_id: $labId, client_id: $clientId, sample_id: $sampleId, test_id: $testId, date_collected: $dateCollected, status: $status, synced: $synced, synced_at: $dateSynced, lab_reference_id: $labReferenceId, location: $location, result: $result, shipment_id: $shipmentId, client_contact: $clientContact, created_at: $dateCreated, modified_at: $dateModified}';
  }
}
