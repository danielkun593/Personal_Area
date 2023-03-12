import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ubik_gps_application_flutter/src/models/sharedPreferencesClass.dart';

class ApiLastPosition{
  UserPreferences userPreferences = UserPreferences();

  //SET CURRENT LOCATION WITH LAST POSITION
  Future<void> setCurrentLocation() async{
    var url = "http://159.89.83.60:8082/position/343";
    final response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if(response.statusCode == 200){
      userPreferences.setLatitude(jsonData['response']['latitude']);
      userPreferences.setLongitude(jsonData['response']['longitude']);
    }else{
      return;
    }
  }
}