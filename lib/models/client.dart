class Client {
  String? clientUid;
  String? clientId;
  String? name;
  String? phone;
  String? districtId;
  String? districtName;
  String? provinceId;
  String? provinceName;
  String? createdBy;
  String? createdDate;
  String? lastModifiedBy;
  String? lastModifiedDate;

  Client(
      {this.clientUid,
      this.clientId,
      this.name,
      this.phone,
      this.districtId,
      this.districtName,
      this.provinceId,
      this.provinceName,
      this.createdBy,
      this.createdDate,
      this.lastModifiedBy,
      this.lastModifiedDate});

  Client.fromJson(Map<String, dynamic> json) {
    clientUid = json['client_uid'];
    clientId = json['client_id'];
    name = json['name'];
    phone = json['phone'];
    districtId = json['district_id'];
    districtName = json['district_name'];
    provinceId = json['province_id'];
    provinceName = json['province_name'];
    createdBy = json['created_by'];
    createdDate = json['created_date'];
    lastModifiedBy = json['last_modified_by'];
    lastModifiedDate = json['last_modified_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['client_uid'] = clientUid;
    data['client_id'] = clientId;
    data['name'] = name;
    data['phone'] = phone;
    data['district_id'] = districtId;
    data['district_name'] = districtName;
    data['province_id'] = provinceId;
    data['province_name'] = provinceName;
    data['created_by'] = createdBy;
    data['created_date'] = createdDate;
    data['last_modified_by'] = lastModifiedBy;
    data['last_modified_date'] = lastModifiedDate;
    return data;
  }
}
