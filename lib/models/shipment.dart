class Shipment {
  int? id;
  String appId = "";
  String description = "";
  String clientId = "";
  late dynamic samples;
  String status = "";
  String dateCreated = "";
  String dateModified = "";
  String riderId = "";
  String riderName = "";
  String destination = "";
  String clusterClientId = "";
  String temperatureOrigin = "";
  String temperatureDestination = "";
  bool isModifiedByHub = false;
  bool isModifiedByFacility = false;
  bool isModifiedByLaboratory = false;
  bool isModifiedByCourier = false;
  String createdBy = "";
  String lastModifiedBy = "";
  String createdDate = "";
  String lastModifiedDate = "";
  bool synced = false;

  Shipment({
    this.id,
    this.appId = "",
    this.description = "",
    this.clientId = "",
    this.samples = const [],
    this.status = "",
    this.dateCreated = "",
    this.dateModified = "",
    this.riderId = "",
    this.riderName = "",
    this.destination = "",
    this.clusterClientId = "",
    this.temperatureOrigin = "",
    this.temperatureDestination = "",
    this.isModifiedByHub = false,
    this.isModifiedByFacility = false,
    this.isModifiedByLaboratory = false,
    this.isModifiedByCourier = false,
    this.createdBy = "",
    this.lastModifiedBy = "",
    this.createdDate = "",
    this.lastModifiedDate = "",
    this.synced = false,
  });

  Shipment.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? json['id'];
    appId = json['appId'];
    description = json['description'];
    clientId = json['clientId'];
    if (json['samples'] != null) {
      samples = <String>[];
      json['samples'].forEach((value) {
        samples.add(value);
      });
    }
    status = json['status'];
    dateCreated = json['dateCreated'];
    dateModified = json['dateModified'];
    riderId = json['riderId'];
    riderName = json['riderName'];
    destination = json['destination'];
    clusterClientId = json['clusterClientId'];
    temperatureOrigin = json['temperatureOrigin'];
    temperatureDestination = json['temperatureDestination'];
    isModifiedByHub = json['isModifiedByHub'] == "true" ? true : false;
    isModifiedByFacility =
        json['isModifiedByFacility'] == "true" ? true : false;
    isModifiedByLaboratory =
        json['isModifiedByLaboratory'] == "true" ? true : false;
    isModifiedByCourier = json['isModifiedByCourrier'] == "true" ? true : false;
    createdBy = json['createdBy'];
    lastModifiedBy = json['lastModifiedBy'] ?? "";
    createdDate = json['createdDate'] ?? "";
    lastModifiedDate = json['createdDate'] ?? "";
    // synced = json['synced'] == null ? false : true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['appId'] = appId;
    data['description'] = description;
    data['clientId'] = clientId;
    data['samples'] = samples;
    data['status'] = status;
    data['dateCreated'] = dateCreated;
    data['dateModified'] = dateModified;
    data['riderId'] = riderId;
    data['riderName'] = riderName;
    data['destination'] = destination;
    data['clusterClientId'] = clusterClientId;
    data['temperatureOrigin'] = temperatureOrigin;
    data['temperatureDestination'] = temperatureDestination;
    data['isModifiedByHub'] = isModifiedByHub.toString();
    data['isModifiedByFacility'] = isModifiedByFacility.toString();
    data['isModifiedByLaboratory'] = isModifiedByLaboratory.toString();
    data['isModifiedByCourrier'] = isModifiedByCourier.toString();
    data['createdBy'] = createdBy;
    data['lastModifiedBy'] = lastModifiedBy;
    data['createdDate'] = createdDate;
    data['lastModifiedDate'] = lastModifiedDate;
    data['synced'] = synced;
    return data;
  }
}
