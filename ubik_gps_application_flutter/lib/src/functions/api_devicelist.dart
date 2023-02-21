// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:ubik_gps_application_flutter/src/models/deviceClass.dart';
import 'package:ubik_gps_application_flutter/src/models/sharedPreferencesClass.dart';
import 'package:http/http.dart' as http;

class ApiDevice{
  UserPreferences userPreferences = UserPreferences();

  //GET LIST DEVICE
  Future<List<Device>> deviceUser(http.Client client, String token) async {
    var url = 'http://159.89.83.60:8080/Resumen';
    var dataHeader = {HttpHeaders.authorizationHeader: "Bearer $token"};
    final response = await client.get(Uri.parse(url), headers: dataHeader);
    final jsonDataOne = jsonDecode(response.body);
    final jsonDataTwo = jsonEncode(jsonDataOne['response']);
    return compute(parsedDevice, jsonDataTwo);
  }

  List<Device> parsedDevice(String responseBdy){
    final parsed = jsonDecode(responseBdy).cast<Map<String, dynamic>>();
    return parsed.map<Device>((json)=>Device.fromJson(json)).toList();
  }
}