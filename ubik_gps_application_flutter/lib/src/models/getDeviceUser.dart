class AllDevice{
  final String deviceId;

  AllDevice({this.deviceId});

  factory AllDevice.fromJson(Map<String, dynamic> json){
    return AllDevice(
      deviceId: json['response']
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'response' : [
        deviceId
      ]
    };
  }
}