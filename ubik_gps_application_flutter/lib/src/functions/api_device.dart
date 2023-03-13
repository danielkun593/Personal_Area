import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ubik_gps_application_flutter/src/models/getDeviceUser.dart';

class ApiDeviced{

  //GET DEVICES USER
  Future<List<AllDevice>> getAllDevice(http.Client client, String token)async{
    List<AllDevice> listDevice = [];
    var urlDevice = "http://159.89.83.60:8080/Devices/get_devices";
    var dataHeader = {HttpHeaders.authorizationHeader: "Bearer $token"};
    final response = await http.get(Uri.parse(urlDevice), headers: dataHeader);
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      for(var d in jsonData['response']){
        listDevice.add(AllDevice(d));
      }
    }
    return listDevice;
  }

  //GET DEVICES USER
  Future<String> getFirstDevice(http.Client client, String token)async{
    var urlDevice = "http://159.89.83.60:8080/Devices/get_devices";
    var dataHeader = {HttpHeaders.authorizationHeader: "Bearer $token"};
    final response = await http.get(Uri.parse(urlDevice), headers: dataHeader);
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      var deviceId = jsonData['response'][0];
      return deviceId;
    }
  }
}