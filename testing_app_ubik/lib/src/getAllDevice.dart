class AllDevice{
  String deviceId;

  AllDevice(this.deviceId);

  AllDevice.fromJson(Map<String, dynamic> json):
        deviceId = json['response'];

  Map<String, dynamic> toJson(){
    return{
      'response' : [
        deviceId
      ]
    };
  }
}