class SampleType {
  String? sampleTypeId;
  String? name;
  String? prefix;
  String? createdBy;
  String? createdDate;
  String? lastModifiedBy;
  String? lastModifiedDate;

  SampleType(
      {this.sampleTypeId,
      this.name,
      this.prefix,
      this.createdBy,
      this.createdDate,
      this.lastModifiedBy,
      this.lastModifiedDate});

  SampleType.fromJson(Map<String, dynamic> json) {
    sampleTypeId = json['sample_type_id'];
    name = json['name'];
    prefix = json['prefix'];
    createdBy = json['created_by'];
    createdDate = json['created_date'];
    lastModifiedBy = json['last_modified_by'];
    lastModifiedDate = json['last_modified_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sample_type_id'] = sampleTypeId;
    data['name'] = name;
    data['prefix'] = prefix;
    data['created_by'] = createdBy;
    data['created_date'] = createdDate;
    data['last_modified_by'] = lastModifiedBy;
    data['last_modified_date'] = lastModifiedDate;
    return data;
  }
}
