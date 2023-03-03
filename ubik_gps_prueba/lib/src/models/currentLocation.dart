class LocationDevice{
  double latitude;
  double longitude;

  LocationDevice(this.latitude, this.longitude);

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude
    };
  }
}