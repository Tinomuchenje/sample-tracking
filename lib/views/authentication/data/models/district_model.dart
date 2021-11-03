class District {
  late String districtId;
  late String name;
  late String provinceId;
  late String provinceName;

  District({
    required this.districtId,
    required this.name,
    required this.provinceId,
    required this.provinceName,
  });

  District.fromJson(Map<String, dynamic> json) {
    districtId = json['districtId'];
    name = json['name'];
    provinceId = json['provinceId'];
    provinceName = json['provinceName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['districtId'] = districtId;
    data['name'] = name;
    data['provinceId'] = provinceId;
    data['provinceName'] = provinceName;
    return data;
  }
}
