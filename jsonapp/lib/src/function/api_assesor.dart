import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:jsonapp/class/asessorClass.dart';

class ApiAsessor{

  //GET DEVICES USER
  Future<List<Assesor>> getAsesor(http.Client client, String token, String typeAssesor)async{
    var urlDevice = "http://159.89.83.60:8080/SmartCare/11/$typeAssesor";
    var dataHeader = {HttpHeaders.authorizationHeader: "Bearer $token"};
    final response = await client.get(Uri.parse(urlDevice), headers: dataHeader);
    final jsonDataOne = jsonDecode(response.body);
    final jsonDataTwo = jsonEncode(jsonDataOne['response']);
    print(response.body);
    return compute(parsedDevice, jsonDataTwo);
  }

  List<Assesor> parsedDevice(String responseBdy){
    final parsed = jsonDecode(responseBdy).cast<Map<String, dynamic>>();
    return parsed.map<Assesor>((json)=> Assesor.fromJson(json)).toList();
  }
}