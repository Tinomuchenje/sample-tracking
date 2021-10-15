class SynchronizationInformation {
  bool isModifiedByHub;
  bool isModifiedByFacility;
  bool isModifiedByLaboratory;
  bool isModifiedByCourrier;

  SynchronizationInformation(
      {this.isModifiedByHub = false,
      this.isModifiedByFacility = false,
      this.isModifiedByLaboratory = false,
      this.isModifiedByCourrier = false});

  // SynchronizationInformation.fromJson(Map<String, dynamic> json) {
  //   isModifiedByHub = json['isModifiedByHub'];
  //   isModifiedByFacility = json['isModifiedByFacility'];
  //   isModifiedByLaboratory = json['isModifiedByLaboratory'];
  //   isModifiedByCourrier = json['isModifiedByCourrier'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['isModifiedByHub'] = isModifiedByHub;
    data['isModifiedByFacility'] = isModifiedByFacility;
    data['isModifiedByLaboratory'] = isModifiedByLaboratory;
    data['isModifiedByCourrier'] = isModifiedByCourrier;
    return data;
  }
}
