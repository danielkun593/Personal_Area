class LocationDevice{
  final String status;
  final String serverTime;
  final double speed;
  final double latitude;
  final double longitude;

  LocationDevice({this.status, this.serverTime, this.speed, this.latitude, this.longitude});

  factory LocationDevice.fromJson(Map<String, dynamic> json){
    return LocationDevice(
      status: json['response'] as String,
      serverTime: json['response'] as String,
      speed: json['response'] as double,
      longitude: json['longitude'] as double,
      latitude: json['latitude'] as double
    );
  }
}