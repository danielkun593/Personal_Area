import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ubik_gps_application_flutter/src/models/getDeviceUser.dart';

class ApiDeviced{
  //GET DEVICES USER
  Future<List<AllDevice>> getAllDevice(http.Client client, String token)async{
    var urlDevice = "http://159.89.83.60:8080/Devices/get_devices";
    var dataHeader = {HttpHeaders.authorizationHeader: "Bearer $token"};
    final response = await http.get(Uri.parse(urlDevice), headers: dataHeader);
    return compute(parsedDevice, response.body);
  }

  List<AllDevice> parsedDevice(String responseBdy){
    final parsed = jsonDecode(responseBdy).cast<Map<String, dynamic>>();
    return parsed.map<AllDevice>((json)=>AllDevice.fromJson(json)).toList();
  }

  Stream<List<AllDevice>> getListAllDevice(http.Client client, String token) async*{
    var urlDevice = "http://159.89.83.60:8080/Devices/get_devices";
    var dataHeader = {HttpHeaders.authorizationHeader: "Bearer $token"};
    final response = await http.get(Uri.parse(urlDevice), headers: dataHeader);
    yield parsedDevice(response.body);
  }
}