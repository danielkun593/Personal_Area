import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ubik_gps_application_flutter/src/models/sharedPreferencesClass.dart';
import 'package:ubik_gps_application_flutter/src/models/userData.dart';

class ApiLogin{
  UserPreferences userPreferences = UserPreferences();
  StateSetter setState;

  //CONNECTION LOGIN WITH ENDPOINT SESSION
  Future<bool> logIn(String email, String password) async {
    var urlLogin = 'http://159.89.83.60:8080/auth/login';
    var dataLogin = {"email": email, "password": password};
    var dataEncoding = jsonEncode(dataLogin);
    var dataHeader = {HttpHeaders.contentTypeHeader: "application/json"};
    final response = await http.post(Uri.parse(urlLogin), body: dataEncoding, headers: dataHeader);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  //LIST DATA USER IN HOMEPAGE
  Future<List<Usuario>> dataUserHome() async {
    var email = await userPreferences.getEmail();
    var password = await userPreferences.getPassword();

    List<Usuario> listData = [];
    var urlLogin = 'http://159.89.83.60:8080/auth/login';
    var dataLogin = {"email": email, "password": password};
    var dataEncoding = jsonEncode(dataLogin);
    var dataHeader = {HttpHeaders.contentTypeHeader: "application/json"};
    final response = await http.post(Uri.parse(urlLogin), body: dataEncoding, headers: dataHeader);
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (var x in jsonData['response']) {
        listData.add(Usuario(x['jwt'], x['name'], x['email'], x['notifications']));
        userPreferences.setToken(x['jwt']);
        userPreferences.setEmail(x['email']);
        userPreferences.setCantNotify(x['notifications']);
      }
      return listData;
    }
  }
}