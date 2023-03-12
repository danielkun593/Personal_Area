class LocationDevice{
  final double latitude;
  final double longitude;

  LocationDevice({this.latitude, this.longitude});

  factory LocationDevice.fromJson(Map<String, dynamic> json){
    return LocationDevice(
      longitude: json['longitude'] as double,
      latitude: json['latitude'] as double
    );
  }
}