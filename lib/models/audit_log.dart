class AuditLog {
  String? createdBy;
  String? modifiedBy;
  String? dateCreated;
  String? dateModified;

  AuditLog(
      {this.createdBy, this.modifiedBy, this.dateCreated, this.dateModified});

  AuditLog.fromJson(Map<String, dynamic> json) {
    createdBy = json['createdBy'];
    modifiedBy = json['modifiedBy'];
    dateCreated = json['dateCreated'];
    dateModified = json['dateModified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdBy'] = createdBy;
    data['modifiedBy'] = modifiedBy;
    data['dateCreated'] = dateCreated;
    data['dateModified'] = dateModified;
    return data;
  }
}
