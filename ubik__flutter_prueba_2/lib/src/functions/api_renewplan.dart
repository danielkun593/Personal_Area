// ignore_for_file: missing_return, avoid_print
import 'dart:convert';
import 'dart:io';
import 'package:ubik_gps_application_flutter/src/models/getRenewPlan.dart';
import 'package:ubik_gps_application_flutter/src/models/sharedPreferencesClass.dart';
import 'package:http/http.dart' as http;

class ApiRenew{
  UserPreferences preferences = UserPreferences();

  //GET USER DATA FOR RENEW PLAN
  Future<List<GetRenewPlan>> dataRenew() async{
    List<GetRenewPlan> listRenew= [];
    var token = await preferences.getToken();
    var url = "http://159.89.83.60:8080/Renovasiones/11";
    var dataHeader = {HttpHeaders.authorizationHeader: "Bearer $token"};
    final response = await http.get(Uri.parse(url), headers: dataHeader);
    var jsonData = jsonDecode(response.body);
    print(jsonData);
    if(response.statusCode == 200){
      for(var x in jsonData['response']){
        listRenew.add(GetRenewPlan(x['name'], x['email'], x['phone'], x['dispositivos'], x['plan'], x['costo']));
      }
      return listRenew;
    }
  }
}