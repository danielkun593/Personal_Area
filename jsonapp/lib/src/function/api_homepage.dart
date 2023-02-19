import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:jsonapp/class/userClass.dart';

class DataUser{
  Future<List<Usuario>> dataUserHome(http.Client client) async {
    var urlLogin = 'http://159.89.83.60:8080/auth/login';
    var dataLogin = {"email": "gmerizalde@gmail.com", "password": "gMerizalde1984"};
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