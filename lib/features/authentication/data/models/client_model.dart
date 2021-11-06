class Client {
  late String id;
  late String clientId;
  late String name;
  late String phone;
  late String emailAddress;
  late String districtId;
  late String district;
  late String provinceId;
  late String province;
  late String emailIddress;

  Client(
      {required this.id,
      required this.clientId,
      required this.name,
      required this.phone,
      required this.emailAddress,
      required this.districtId,
      required this.district,
      required this.provinceId,
      required this.province,
      required this.emailIddress});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['clientId'];
    name = json['name'];
    phone = json['phone'];
    emailAddress = json['emailAddress'];
    districtId = json['districtId'];
    district = json['district'];
    provinceId = json['provinceId'];
    province = json['province'];
    emailIddress = json['emailIddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['clientId'] = clientId;
    data['name'] = name;
    data['phone'] = phone;
    data['emailAddress'] = emailAddress;
    data['districtId'] = districtId;
    data['district'] = district;
    data['provinceId'] = provinceId;
    data['province'] = province;
    data['emailIddress'] = emailIddress;
    return data;
  }
}
