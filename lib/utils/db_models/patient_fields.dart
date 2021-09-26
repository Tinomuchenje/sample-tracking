class PatientFields {
  static final List<String> values = [
    patientId,
    firstname,
    lastname,
    gender,
    dob,
    client,
    clientPatientId,
    cohortNumber,
    dateCreated,
    dateModified
  ];
  static const String patientId = "patient_id";
  static const String firstname = "firstname";
  static const String lastname = "lastname";
  static const String gender = "gender";
  static const String dob = "dob";
  static const String client = "client";
  static const String clientPatientId = "client_patient_id";
  static const String cohortNumber = "cohort_number";
  static const String dateCreated = "created_at";
  static const String dateModified = "modified_at";
}
