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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sample_type_id'] = this.sampleTypeId;
    data['name'] = this.name;
    data['prefix'] = this.prefix;
    data['created_by'] = this.createdBy;
    data['created_date'] = this.createdDate;
    data['last_modified_by'] = this.lastModifiedBy;
    data['last_modified_date'] = this.lastModifiedDate;
    return data;
  }
}
