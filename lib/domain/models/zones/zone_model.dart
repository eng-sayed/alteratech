class WooZonesModel {
  String? locationId;
  String? zoneId;
  String? locationCode;
  String? locationType;

  WooZonesModel(
      {this.locationId, this.zoneId, this.locationCode, this.locationType});

  WooZonesModel.fromJson(Map<String, dynamic> json) {
    locationId = json['location_id'];
    zoneId = json['zone_id'];
    locationCode = json['location_code'];
    locationType = json['location_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location_id'] = this.locationId;
    data['zone_id'] = this.zoneId;
    data['location_code'] = this.locationCode;
    data['location_type'] = this.locationType;
    return data;
  }
}
