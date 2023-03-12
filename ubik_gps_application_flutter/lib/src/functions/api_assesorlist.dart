// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ubik_gps_application_flutter/src/models/getAsessor.dart';

class ApiAssesor{

  //GET ASSESORS API
  Future<List<Assesor>> asesorUser(http.Client client, String typeAssesor, String token) async{
    var url = "http://159.89.83.60:8080/SmartCare/11/$typeAssesor";
    var dataHeader = {HttpHeaders.authorizationHeader: "Bearer $token"};
    final response = await http.get(Uri.parse(url), headers: dataHeader);
    final jsonDataOne = jsonDecode(response.body);
    final jsonDataTwo = jsonEncode(jsonDataOne['response']);
    print(jsonDataTwo);
    return compute(parsedAsesor, jsonDataTwo);
  }
  List<Assesor> parsedAsesor(String responseBdy){
    final parsed = jsonDecode(responseBdy).cast<Map<String, dynamic>>();
    return parsed.map<Assesor>((json)=>Assesor.fromJson(json)).toList();
  }
}