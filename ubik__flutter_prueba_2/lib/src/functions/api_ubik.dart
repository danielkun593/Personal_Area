// ignore_for_file: deprecated_member_use, avoid_print, missing_return
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ubik_gps_application_flutter/src/models/sharedPreferencesClass.dart';

class ApiUbik {
  UserPreferences userPreferences = UserPreferences();

  //SEND COMMANDS ENDPOINT  UBIK SERVER COMUN
  Future<bool> commandSend(String typeCommand, int deviceId, String imei) async {
    var url = "http://159.89.83.60:8082/command/testing";
    var head = {HttpHeaders.contentTypeHeader: "application/json"};
    var body = {"deviceId": deviceId, "uniqueId": imei, "type": typeCommand};
    final response = await http.post(Uri.parse(url), headers: head, body: body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}