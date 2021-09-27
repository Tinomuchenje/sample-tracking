class Laboratory {
  String? laboratoryId;
  String? name;
  String? type;
  String? code;
  String? createdBy;
  String? createdDate;
  String? lastModifiedBy;
  String? lastModifiedDate;

  Laboratory(
      {required this.laboratoryId,
      this.name,
      this.type,
      this.code,
      this.createdBy,
      this.createdDate,
      this.lastModifiedBy,
      this.lastModifiedDate});

  Laboratory.fromJson(Map<String, dynamic> json) {
    laboratoryId = json['laboratory_id'];
    name = json['name'];
    type = json['type'];
    code = json['code'];
    createdBy = json['created_by'];
    createdDate = json['created_date'];
    lastModifiedBy = json['last_modified_by'];
    lastModifiedDate = json['last_modified_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['laboratory_id'] = laboratoryId;
    data['name'] = name;
    data['type'] = type;
    data['code'] = code;
    data['created_by'] = createdBy;
    data['created_date'] = createdDate;
    data['last_modified_by'] = lastModifiedBy;
    data['last_modified_date'] = lastModifiedDate;
    return data;
  }
}
