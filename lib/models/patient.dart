class Patient {
  String patientId;
  String firstname;
  String lastname;
  String gender;
  DateTime dob;
  String client;
  String clientPatientId;
  String cohortNumber;
  DateTime dateCreated;
  DateTime dateModified;

  Patient(
      this.patientId,
      this.firstname,
      this.lastname,
      this.gender,
      this.dob,
      this.client,
      this.clientPatientId,
      this.cohortNumber,
      this.dateCreated,
      this.dateModified);

  Map<String, dynamic> toMap() {
    return {
      'patient_id': patientId,
      'firstname': firstname,
      'lastname': lastname,
      'gender': gender,
      'dob': dob.toString(),
      'client': client,
      'client_patient_id': clientPatientId,
      'cohort_number': cohortNumber,
      'created_at': dateCreated.toString(),
      'modified_at': dateModified.toString(),
    };
  }

  @override
  String toString() {
    return 'Patient{patient_id: $patientId, firstname: $firstname, lastname: $lastname, gender: $gender, dob: $dob, client: $client, client_patient_id: $clientPatientId, cohort_number: $cohortNumber, created_at: $dateCreated, modified_at: $dateModified}';
  }
}
