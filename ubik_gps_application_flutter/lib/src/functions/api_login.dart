import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ubik_gps_application_flutter/src/models/sharedPreferencesClass.dart';
import 'package:ubik_gps_application_flutter/src/models/userData.dart';

class ApiLogin{
  UserPreferences userPreferences = UserPreferences();
  StateSetter setState;

  //CONNECTION LOGIN WITH ENDPOINT SESSION
  Future<bool> logIn(http.Client client, String email, String password) async {
    var urlLogin = 'http://159.89.83.60:8080/auth/login';
    var dataLogin = {"email": email, "password": password};
    var dataEncoding = jsonEncode(dataLogin);
    var dataHeader = {HttpHeaders.contentTypeHeader: "application/json"};
    final response = await client.post(Uri.parse(urlLogin), body: dataEncoding, headers: dataHeader);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
  //LIST DATA USER IN HOMEPAGE
  Future<List<Usuario>> dataUserHome(http.Client client, String email, String password) async {
    var urlLogin = 'http://159.89.83.60:8080/auth/login';
    var dataLogin = {"email": email, "password": password};
    var dataEncoding = jsonEncode(dataLogin);
    var dataHeader = {HttpHeaders.contentTypeHeader: "application/json"};
    final response = await client.post(Uri.parse(urlLogin), body: dataEncoding, headers: dataHeader);
    final jsonDataOne = jsonDecode(response.body);
    final jsonDataTwo = jsonEncode(jsonDataOne['response']);
    return compute(parsedUser, jsonDataTwo);
  }

  List<Usuario> parsedUser(String responseBdy){
    final parsed = jsonDecode(responseBdy).cast<Map<String, dynamic>>();
    return parsed.map<Usuario>((json)=>Usuario.fromJson(json)).toList();
  }
}