class Client {
  String? id;
  String? clientId;
  String? name;
  String? phone;
  String? emailAddress;
  String? districtId;
  String? district;
  String? provinceId;
  String? province;
  Null clientContacts;
  String? emailIddress;

  Client(
      {this.id,
        this.clientId,
        this.name,
        this.phone,
        this.emailAddress,
        this.districtId,
        this.district,
        this.provinceId,
        this.province,
        this.clientContacts,
        this.emailIddress});

  Client.fromJson(Map<String?, dynamic> json) {
    id = json['id'];
    clientId = json['clientId'];
    name = json['name'];
    phone = json['phone'];
    emailAddress = json['emailAddress'];
    districtId = json['districtId'];
    district = json['district'];
    provinceId = json['provinceId'];
    province = json['province'];
    clientContacts = json['clientContacts'];
    emailIddress = json['emailIddress'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['clientId'] = this.clientId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['emailAddress'] = this.emailAddress;
    data['districtId'] = this.districtId;
    data['district'] = this.district;
    data['provinceId'] = this.provinceId;
    data['province'] = this.province;
    data['clientContacts'] = this.clientContacts;
    data['emailIddress'] = this.emailIddress;
    return data;
  }
}