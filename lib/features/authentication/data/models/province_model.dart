class Province {
  late String provinceId;
  late String name;
  String? state;

  Province({required this.provinceId, required this.name, this.state});

  Province.fromJson(Map<String, dynamic> json) {
    provinceId = json['provinceId'];
    name = json['name'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['provinceId'] = provinceId;
    data['name'] = name;
    data['state'] = state;
    return data;
  }
}
