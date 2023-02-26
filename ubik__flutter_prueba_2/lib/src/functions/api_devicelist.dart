import 'dart:convert';
import 'dart:io';
import 'package:ubik_gps_application_flutter/src/models/deviceClass.dart';
import 'package:ubik_gps_application_flutter/src/models/sharedPreferencesClass.dart';
import 'package:http/http.dart' as http;

class ApiDevice{
  UserPreferences userPreferences = UserPreferences();

  //GET LIST DEVICE
  Future<List<Device>> deviceUser() async {
    List<Device> list = [];
    var token = await userPreferences.getToken();
    var url = 'http://159.89.83.60:8080/Resumen';
    var dataHeader = {HttpHeaders.authorizationHeader: "Bearer $token"};
    final response = await http.get(Uri.parse(url), headers: dataHeader);
    var jsonData = jsonDecode(response.body);
    print(jsonData['response']);
    if (response.statusCode == 200) {
      for (var item in jsonData['response']) {
        list.add(Device(item['device_status'], item['user_name'], item['speed'], item['latitude'], item['longitude'], item['device_time']));
      }
      return list;
    } else {
      throw Exception("ERROR EN LA CONSULTA DE LA ENDPOINT");
    }
  }
}