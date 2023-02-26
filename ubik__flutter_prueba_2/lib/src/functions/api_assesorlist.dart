// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ubik_gps_application_flutter/src/models/getAsessor.dart';
import 'package:ubik_gps_application_flutter/src/models/sharedPreferencesClass.dart';

class ApiAssesor{
  UserPreferences userPreferences = UserPreferences();

  //GET ASSESORS API
  Future<List<Assesor>> asesorUser(String typeAssesor) async{
    List<Assesor> asesores = [];
    var token = await userPreferences.getToken();
    var url = "http://159.89.83.60:8080/SmartCare/11/$typeAssesor";
    var dataHeader = {
      HttpHeaders.authorizationHeader: "Bearer $token",
      HttpHeaders.acceptLanguageHeader:"en-US"
    };
    final response = await http.get(Uri.parse(url), headers: dataHeader);
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      print(jsonData);
      for(var a in jsonData['response']){
        asesores.add(Assesor(a['nombre'], a['telefono'], a['correo'], a['asesoria']));
      }
      return asesores;
    }
  }
}