// ignore_for_file: non_constant_identifier_names
class Dispositivo {
  int id;
  String statusDevice;
  String name;
  String lastUpdate;
  //String atributos_timezone;
  //double atributos_speedlimit;
  String numberPhone;
  String modelCar;
  String category;

  Dispositivo(
      this.id,
      this.statusDevice,
      this.name,
      this.lastUpdate,
      //this.atributos_timezone,
      //this.atributos_speedlimit,
      this.numberPhone,
      this.modelCar,
      this.category
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': statusDevice,
      'name': name,
      'lastupdate': lastUpdate,
      /*'attributes': {
        'decoder.timezone': atributos_timezone,
        'speedLimit': atributos_speedlimit
      },*/
      'phone': numberPhone,
      'model': modelCar,
      'category': category
    };
  }
}
class Device {
  String statusDevice;
  String name_user;
  double speed;
  double latitude;
  double longitude;
  String device_time;

  Device(
      this.statusDevice,
      this.name_user,
      this.speed,
      this.latitude,
      this.longitude,
      this.device_time
      );

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
