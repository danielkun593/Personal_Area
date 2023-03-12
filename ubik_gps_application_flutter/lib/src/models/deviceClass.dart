// ignore_for_file: non_constant_identifier_names
class Device {
  final String statusDevice;
  final String name_user;
  final double speed;
  final double latitude;
  final double longitude;
  final String device_time;

  Device({this.statusDevice, this.name_user, this.speed, this.latitude, this.longitude, this.device_time});

  factory Device.fromJson(Map<String, dynamic> json){
    return Device(
      statusDevice: json['device_status'] as String,
      name_user: json['user_name'] as String,
      speed: json['speed'] as double,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      device_time: json['device_time'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_name': name_user,
      'speed': speed,
      'longitude': longitude,
      'latitude': latitude,
      'device_time': device_time
    };
  }
}

class DirectionAddress{
  final double latitude;
  final double longitude;

  DirectionAddress(this.latitude, this.longitude);
}