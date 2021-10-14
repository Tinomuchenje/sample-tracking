import 'package:sample_tracking_system_flutter/models/audit_log.dart';

class Patient {
  String? id;
  String? firstname;
  String? lastname;
  String? gender;
  String? dob;
  String? client;
  String? clientPatientId;
  String? cohortNumber;
  String? dateCreated;
  String? dateModified;
  String? phoneNumber;
  AuditLog? auditLog;

  Patient(
      {this.id,
      this.firstname,
      this.lastname,
      this.gender,
      this.dob,
      this.client,
      this.clientPatientId,
      this.cohortNumber,
      this.phoneNumber,
      this.dateCreated,
      this.dateModified,
      this.auditLog});

  Map<String, dynamic> toMap() {
    return {
      'patient_id': id,
      'firstname': firstname,
      'lastname': lastname,
      'gender': gender,
      'dob': dob.toString(),
      'client': client,
      'clientPatientId': clientPatientId,
      'cohortNumber': cohortNumber,
      'created_at': dateCreated.toString(),
      'modified_at': dateModified.toString(),
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['gender'] = gender;
    data['dob'] = dob;
    data['client'] = client;
    data['clientPatientId'] = clientPatientId;
    data['cohortNumber'] = cohortNumber;
    data['dateCreated'] = dateCreated;
    data['dateModified'] = dateModified;
    data['phoneNumber'] = phoneNumber;
    data['auditLog'] = auditLog?.toJson();
    return data;
  }

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    gender = json['gender'];
    dob = json['dob'];
    client = json['client'];
    clientPatientId = json['clientPatientId'];
    cohortNumber = json['cohortNumber'];
    dateCreated = json['dateCreated'];
    dateModified = json['dateModified'];
    phoneNumber = json['phoneNumber'];
    auditLog =
        json['auditLog'] != null ? AuditLog.fromJson(json['auditLog']) : null;
  }

  @override
  String toString() {
    return 'Patient{patient_id: $id, firstname: $firstname, lastname: $lastname, gender: $gender, dob: $dob, client: $client, client_patient_id: $clientPatientId, cohort_number: $cohortNumber, created_at: $dateCreated, modified_at: $dateModified}';
  }
}
