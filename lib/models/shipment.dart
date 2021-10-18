class Shipment {
  String? id;
  String? appId;
  String? description;
  String? clientId;
  late List<String> samples;
  String? status;
  String? dateCreated;
  String? dateModified;
  String? riderId;
  String? riderName;
  String? destination;
  String? clusterClientId;
  String? temperatureOrigin;
  String? temperatureDestination;
  bool isModifiedByHub = false;
  bool isModifiedByFacility = false;
  bool isModifiedByLaboratory = false;
  bool isModifiedByCourier = false;
  String? createdBy;
  String? lastModifiedBy;
  String? createdDate;
  String? lastModifiedDate;

  Shipment(
      {this.id,
      this.appId,
      this.description,
      this.clientId,
      required this.samples,
      this.status,
      this.dateCreated,
      this.dateModified,
      this.riderId,
      this.riderName,
      this.destination,
      this.clusterClientId,
      this.temperatureOrigin,
      this.temperatureDestination,
      this.isModifiedByHub = false,
      this.isModifiedByFacility = false,
      this.isModifiedByLaboratory = false,
      this.isModifiedByCourier = false,
      this.createdBy,
      this.lastModifiedBy,
      this.createdDate,
      this.lastModifiedDate});

  Shipment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    isModifiedByHub = json['isModifiedByHub'];
    isModifiedByFacility = json['isModifiedByFacility'];
    isModifiedByLaboratory = json['isModifiedByLaboratory'];
    isModifiedByCourier = json['isModifiedByCourrier'];
    createdBy = json['createdBy'];
    lastModifiedBy = json['lastModifiedBy'];
    createdDate = json['createdDate'];
    lastModifiedDate = json['createdDate'];
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
    return data;
  }
}
