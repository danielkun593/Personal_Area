import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ubik_gps_application_flutter/src/models/getDeviceImei.dart';
import 'package:ubik_gps_application_flutter/src/models/sharedPreferencesClass.dart';

class ApiIdentificationDevice{
  UserPreferences userPreferences = UserPreferences();

  //GET IMEI DEVICE USER
  Future<List<DeviceImei>> getImei(int deviceID)async{
    List<DeviceImei> listImeiDevice = [];
    var token = await userPreferences.getToken();
    var urlDevice = "http://159.89.83.60:8080/Devices/get_devices/$deviceID";
    var dataHeader = {HttpHeaders.authorizationHeader: "Bearer $token"};
    final response = await http.get(Uri.parse(urlDevice), headers: dataHeader);
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      for(var d in jsonData){
        listImeiDevice.add(DeviceImei(d['response']));
      }
    }
    return listImeiDevice;
  }
}