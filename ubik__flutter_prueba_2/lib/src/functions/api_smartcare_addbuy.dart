import 'dart:convert';
import 'dart:io';
import 'package:ubik_gps_application_flutter/src/models/sharedPreferencesClass.dart';
import 'package:http/http.dart' as http;

class ApiSmartCare{
  UserPreferences preferences = UserPreferences();

  Future<bool> setVehicle(
      String name, String date, String km, String marca, String anio, String model,
      String description, String number)async{
    var token = await preferences.getToken();
    var url = "http://159.89.83.60:8080/ComVen";
    var dataHeader={
      HttpHeaders.authorizationHeader: "Bearer $token",
      HttpHeaders.contentTypeHeader: "application/json"
    };
    var dataBody = {
      "name": name, "fecha": date,
      "recorrido": "$km km",
      "marca": marca, "ano": anio,
      "marca_modelo": model,
      "descripcion": description, "contacto": number
    };
    final response = await http.post(Uri.parse(url), headers: dataHeader, body: dataBody);
    if(response.statusCode ==  200){
      return true;
    }else{
      return false;
    }
  }
}