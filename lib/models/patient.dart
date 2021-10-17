class Patient {
  String id = "";
  String appId = "";
  String firstName = "";
  String lastName = "";
  String gender = "";
  String dob = "";
  String client = "";
  String clientPatientId = "";
  String cohortNumber = "";
  String phoneNumber = "";
  String createdBy = "";
  String lastModifiedBy = "";
  String createdDate = "";
  String lastModifiedDate = "";

  Patient(
      {this.id = "",
      this.appId = "",
      this.firstName = "",
      this.lastName = "",
      this.gender = "",
      this.dob = "",
      this.client = "",
      this.clientPatientId = "",
      this.cohortNumber = "",
      this.phoneNumber = "",
      this.createdBy = "",
      this.lastModifiedBy = "",
      this.createdDate = "",
      this.lastModifiedDate = ""});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['appId'] = appId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['gender'] = gender;
    data['dob'] = dob;
    data['client'] = client;
    data['clientPatientId'] = clientPatientId;
    data['cohortNumber'] = cohortNumber;
    data['phoneNumber'] = phoneNumber;
    data['createdBy'] = createdBy;
    data['lastModifiedBy'] = lastModifiedBy;
    data['createdDate'] = createdDate;
    data['lastModifiedDate'] = lastModifiedDate;
    return data;
  }

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    appId = json['appId'];
    firstName = json['lastName'];
    lastName = json['lastName'];
    gender = json['gender'];
    dob = json['dob'];
    client = json['client'];
    clientPatientId = json['clientPatientId'];
    cohortNumber = json['cohortNumber'];
    phoneNumber = json['phoneNumber'];
    createdBy = json['createdBy'];
    lastModifiedBy = json['lastModifiedBy'];
    createdDate = json['createdDate'];
    lastModifiedDate = json['lastModifiedDate'];
  }
}
