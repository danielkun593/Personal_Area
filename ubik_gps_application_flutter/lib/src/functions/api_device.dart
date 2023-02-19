import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ubik_gps_application_flutter/src/models/getDeviceUser.dart';
import 'package:ubik_gps_application_flutter/src/models/sharedPreferencesClass.dart';

class ApiDeviced{
  UserPreferences userPreferences = UserPreferences();

  //GET DEVICES USER
  Future<List<AllDevice>> getAllDevice()async{
    List<AllDevice> listDevice = [];
    var token = await userPreferences.getToken();
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
}