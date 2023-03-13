import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:testing_app_ubik/src/models/getDataVehicle.dart';


class ApiSmartCare{

  Future<bool> setVehicle(http.Client client, String token, String name, String date,
    String km, String marca, String anio, String model, String description, String number)async{
    var url = "http://159.89.83.60:8080/ComVen";
    var dataHeader={HttpHeaders.authorizationHeader: "Bearer $token", HttpHeaders.contentTypeHeader: "application/json"};
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
    if(response.statusCode ==  200){
      return true;
    }else{
      return false;
    }
  }

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
}