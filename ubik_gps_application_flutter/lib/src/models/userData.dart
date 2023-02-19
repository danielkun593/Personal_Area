// ignore_for_file: sdk_version_ui_as_code
class Usuario {
  //List<dynamic> deviceId;
  //List<String> dev;
  String jwt;
  String name;
  String email;
  //Map notifications;
  int notifications;

  Usuario(
      //this.deviceId,
      this.jwt,
      this.name,
      this.email,
      this.notifications);

  /*ConvertIntToString(){
    String idDevice;
    for(int x =0; x <deviceId.length; x++){
      idDevice = deviceId[x].toString();
    }
    return idDevice;
  }*/

  Usuario.fromJson(Map<String, dynamic> json)
      :
        //deviceId = json['devices'],
        jwt = json['jwt'],
        email = json['email'],
        name = json['name'],
        notifications = json['notifications'];

  Map<String, dynamic> toJson() {
    //dev = ConvertIntToString();
    return {
      /*'devices': {
        dev
      },*/
      'jwt': jwt,
      'name': name,
      'email' : email,
      'notifications': notifications
    };
  }
}
