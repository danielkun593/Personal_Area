class DeviceImei{
  String deviceImei;

  DeviceImei(this.deviceImei);

  DeviceImei.fromJson(Map<String, dynamic> json):
        deviceImei = json['response'];

  Map<String, dynamic> toJson(){
    return{
      'response' : deviceImei
    };
  }
}