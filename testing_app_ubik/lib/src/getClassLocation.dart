class LocationDevice{
  final int deviceId;
  final String status;
  final String serverTime;
  final double speed;
  final double latitude;
  final double longitude;

  LocationDevice({this.deviceId ,this.status, this.serverTime, this.speed, this.latitude, this.longitude});

  factory LocationDevice.fromJson(Map<String, dynamic> json){
    return LocationDevice(
        deviceId: json['deviceId'] as int,
        status: json['status'] as String,
        serverTime: json['server_time'] as String,
        speed: json['speed'] as double,
        longitude: json['longitude'] as double,
        latitude: json['latitude'] as double
    );
  }
}