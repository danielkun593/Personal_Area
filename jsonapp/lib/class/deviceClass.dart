class AllDevice{
  final String deviceId;

  AllDevice({required this.deviceId});

  factory AllDevice.fromJson(Map<String, dynamic> json) {
    return AllDevice(
      deviceId: json['response'] as String,
    );
  }
}