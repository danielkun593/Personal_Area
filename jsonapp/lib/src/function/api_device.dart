import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:jsonapp/class/deviceClass.dart';

class ApiDeviced{

  //GET DEVICES USER
  Future<List<AllDevice>> getAllDevice(http.Client client, String token)async{
    var urlDevice = "http://159.89.83.60:8080/Devices/get_devices";
    var dataHeader = {HttpHeaders.authorizationHeader: "Bearer $token"};
    final response = await client.get(Uri.parse(urlDevice), headers: dataHeader);
    final jsonDataOne = jsonDecode(response.body);
    final jsonDataTwo = jsonEncode(jsonDataOne['response']);
    print(response.body);
    return compute(parsedDevice, jsonDataTwo);
  }

  List<AllDevice> parsedDevice(String responseBdy){
    final parsed = jsonDecode(responseBdy).cast<Map<String, dynamic>>();
    return parsed.map<AllDevice>((json)=> AllDevice.fromJson(json)).toList();
  }
}