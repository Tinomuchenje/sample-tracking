class ClientContact {
  String? clientContactId;
  String? title;
  String? clientContactUuid;
  int? phone;
  String? emailAddress;
  String? ccContact;
  String? clientId;
  String? createdBy;
  String? createdDate;
  String? lastModifiedBy;
  String? lastModifiedDate;
  String? clientClientUid;

  ClientContact(
      {this.clientContactId,
      this.title,
      this.clientContactUuid,
      this.phone,
      this.emailAddress,
      this.ccContact,
      this.clientId,
      this.createdBy,
      this.createdDate,
      this.lastModifiedBy,
      this.lastModifiedDate,
      this.clientClientUid});

  ClientContact.fromJson(Map<String, dynamic> json) {
    clientContactId = json['client_contact_id'];
    title = json['title'];
    clientContactUuid = json['client_contact_uuid'];
    phone = json['phone'];
    emailAddress = json['email_address'];
    ccContact = json['cc_contact'];
    clientId = json['client_id'];
    createdBy = json['created_by'];
    createdDate = json['created_date'];
    lastModifiedBy = json['last_modified_by'];
    lastModifiedDate = json['last_modified_date'];
    clientClientUid = json['client_client_uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['client_contact_id'] = clientContactId;
    data['title'] = title;
    data['client_contact_uuid'] = clientContactUuid;
    data['phone'] = phone;
    data['email_address'] = emailAddress;
    data['cc_contact'] = ccContact;
    data['client_id'] = clientId;
    data['created_by'] = createdBy;
    data['created_date'] = createdDate;
    data['last_modified_by'] = lastModifiedBy;
    data['last_modified_date'] = lastModifiedDate;
    data['client_client_uid'] = clientClientUid;
    return data;
  }
}
