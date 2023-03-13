// ignore_for_file: missing_return, avoid_print
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:testing_app_ubik/src/models/getRenewPlan.dart';
import 'package:http/http.dart' as http;

class ApiRenew{
  //GET USER DATA FOR RENEW PLAN
  Future<List<GetRenewPlan>> dataRenew(http.Client client, String token) async{
    var url = "http://159.89.83.60:8080/Renovasiones/11";
    var dataHeader = {HttpHeaders.authorizationHeader: "Bearer $token"};
    final response = await client.get(Uri.parse(url), headers: dataHeader);
    final jsonDataOne = jsonDecode(response.body);
    final jsonDataTwo = jsonEncode(jsonDataOne['response']);
    return compute(parsedRenew, jsonDataTwo);
  }

  List<GetRenewPlan> parsedRenew(String responseBdy){
    final parsed = jsonDecode(responseBdy).cast<Map<String, dynamic>>();
    return parsed.map<GetRenewPlan>((json)=>GetRenewPlan.fromJson(json)).toList();
  }
}