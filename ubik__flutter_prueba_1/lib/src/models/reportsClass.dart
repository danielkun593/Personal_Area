// ignore_for_file: non_constant_identifier_names
class Reportes {
  int id;
  String protocol;
  int deviceId;
  String tiempoServicio;
  String deviceTiempoServicio;
  double latitud;
  double longitud;

  Reportes(
      this.id,
      this.protocol,
      this.deviceId,
      this.tiempoServicio,
      this.deviceTiempoServicio,
      this.latitud,
      this.longitud);


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'protocol': protocol,
      'deviceid': deviceId,
      'servertime': tiempoServicio,
      'devicetime': deviceTiempoServicio,
      'latitude': latitud,
      'longitude': longitud,
    };
  }
}

class ReportesDevice{
  int id;
  String tipo;
  String servidorTiempo;
  int deviceId;
  int geofenceID;
  String atributo_alarma;
  int maintenancedId;

  ReportesDevice(
      this.id,
      this.tipo,
      this.servidorTiempo,
      this.deviceId,
      this.geofenceID,
      this.atributo_alarma,
      this.maintenancedId);

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "type": tipo,
      "servertime": servidorTiempo,
      "deviceid": deviceId,
      "geofenceid": geofenceID,
      "attributes": {"alarm": atributo_alarma},
      "maintenanceid": maintenancedId,
    };
  }


}
