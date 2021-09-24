class Patient {
   String patient_id;
   String firstname;
   String lastname;
   String gender; // could be enum
   DateTime dob;
   String client;
   String client_patient_id;
   String cohort_number;
   DateTime created_at;
   DateTime modified_at;

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
}