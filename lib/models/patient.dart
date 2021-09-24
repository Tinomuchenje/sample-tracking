class Patient {
  final String patient_id;
  final String firstname;
  final String lastname;
  final String gender;
  final DateTime dob;
  final String client;
  final String client_patient_id;
  final String cohort_number;
  final DateTime created_at;
  final DateTime modified_at;

  Patient(
      this.patient_id,
      this.firstname,
      this.lastname,
      this.gender,
      this.dob,
      this.client,
      this.client_patient_id,
      this.cohort_number,
      this.created_at,
      this.modified_at);

  Map<String, dynamic> toMap() {
    return {
      'patient_id': patient_id,
      'firstname': firstname,
      'lastname': lastname,
      'gender': gender,
      'dob': dob.toString(),
      'client': client,
      'client_patient_id': client_patient_id,
      'cohort_number': cohort_number,
      'created_at': created_at.toString(),
      'modified_at': modified_at.toString(),
    };
  }

  @override
  String toString() {
    return 'Patient{patient_id: $patient_id, firstname: $firstname, lastname: $lastname, gender: $gender, dob: $dob, client: $client, client_patient_id: $client_patient_id, cohort_number: $cohort_number, created_at: $created_at, modified_at: $modified_at}';
  }
}
