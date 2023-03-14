import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:testing_app_ubik/src/getClassLocation.dart';

class ApiPosition{
  //SET CURRENT LOCATION WITH LAST POSITION
  Future<List<LocationDevice>> setCurrentLocation(http.Client client, String device) async{
    var deviceId = int.parse(device);
    var url = "http://159.89.83.60:8082/position/$deviceId";
    final response = await http.get(Uri.parse(url));
    final jsonData = jsonDecode(response.body);
    final jsonDataResponse = jsonEncode(jsonData['response']);
    return compute(parsedLocation, jsonDataResponse);
  }

  Future<List<LocationDevice>> setCurrentLocationAll(http.Client client, String token) async{
    var url = "http://159.89.83.60:8080/Positions";
    var dataAuthorization = {HttpHeaders.authorizationHeader: "Bearer $token"};
    final response = await http.get(Uri.parse(url), headers: dataAuthorization);
    final jsonData = jsonDecode(response.body);
    final jsonDataResponse = jsonEncode(jsonData['response']);
    print(jsonDataResponse);
    return compute(parsedLocation, jsonDataResponse);
  }

  List<LocationDevice> parsedLocation(String responseBdy){
    final parsed = jsonDecode(responseBdy).cast<Map<String, dynamic>>();
    return parsed.map<LocationDevice>((json)=>LocationDevice.fromJson(json)).toList();
  }
}