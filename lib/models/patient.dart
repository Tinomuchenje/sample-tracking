final String tablePatient = "patient";
class PatientFields {
  static final List<String> values = [
    patient_id,
    firstname,
    lastname,
    gender,
    dob,
    client,
    client_patient_id,
    cohort_number,
    created_at,
    modified_at
  ];
  static final String patient_id = "patient_id";
  static final String firstname = "firstname";
  static final String lastname = "lastname";
  static final String gender = "gender";
  static final String dob = "dob";
  static final String client = "client";
  static final String client_patient_id = "client_patient_id";
  static final String cohort_number = "cohort_number";
  static final String created_at = "created_at";
  static final String modified_at = "modified_at";
}

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
