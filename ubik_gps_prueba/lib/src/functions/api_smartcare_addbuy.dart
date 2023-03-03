import 'dart:convert';
import 'dart:io';
<<<<<<< HEAD
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ubik_gps_application_flutter/src/models/getDataVehicle.dart';

class ApiSmartCare{

  Future<bool> setVehicle(
      http.Client client, String token, String name, String date, String km, String marca, String anio, String model,
      String description, String number)async{
=======
import 'package:ubik_gps_application_flutter/src/models/sharedPreferencesClass.dart';
import 'package:http/http.dart' as http;

class ApiSmartCare{
  UserPreferences preferences = UserPreferences();

  Future<bool> setVehicle(
      String name, String date, String km, String marca, String anio, String model,
      String description, String number)async{
    var token = await preferences.getToken();
>>>>>>> 1d4bf42f06c44f9ba9989754458cb0f0a37f91cf
    var url = "http://159.89.83.60:8080/ComVen";
    var dataHeader={
      HttpHeaders.authorizationHeader: "Bearer $token",
      HttpHeaders.contentTypeHeader: "application/json"
    };
<<<<<<< HEAD
    var data = {
      "name": name,
      "fecha": date,
      "recorrido": "$km km",
      "ano": anio,
      "marca_modelo": "$model / $marca",
      "descripcion": description,
      "contacto": number
    };
    var dataBody = jsonEncode(data);
    final response = await client.post(Uri.parse(url), headers: dataHeader, body: dataBody);
=======
    var dataBody = {
      "name": name, "fecha": date,
      "recorrido": "$km km",
      "marca": marca, "ano": anio,
      "marca_modelo": model,
      "descripcion": description, "contacto": number
    };
    final response = await http.post(Uri.parse(url), headers: dataHeader, body: dataBody);
>>>>>>> 1d4bf42f06c44f9ba9989754458cb0f0a37f91cf
    if(response.statusCode ==  200){
      return true;
    }else{
      return false;
    }
  }
<<<<<<< HEAD

  Future<List<SelfVehicle>> getVehicle(http.Client client, String token)async{
    var url = "http://159.89.83.60:8080/ComVen";
    var dataHeader={
      HttpHeaders.authorizationHeader: "Bearer $token",
      HttpHeaders.contentTypeHeader: "application/json"
    };
    final response = await client.get(Uri.parse(url), headers: dataHeader);
    final jsonDataOne = jsonDecode(response.body);
    final jsonDataTwo = jsonEncode(jsonDataOne['response']);
    return compute(parsedSmartCare, jsonDataTwo);
  }

  List<SelfVehicle> parsedSmartCare(String responseBdy){
    final parsed = jsonDecode(responseBdy).cast<Map<String, dynamic>>();
    return parsed.map<SelfVehicle>((json)=>SelfVehicle.fromJson(json)).toList();
  }
=======
>>>>>>> 1d4bf42f06c44f9ba9989754458cb0f0a37f91cf
}