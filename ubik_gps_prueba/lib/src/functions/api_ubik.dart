// ignore_for_file: deprecated_member_use, avoid_print, missing_return
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiUbik {
  //868166051857894

  //SEND COMMANDS ENDPOINT  UBIK SERVER COMUN
  Future<bool> commandSend(http.Client client, int deviceId, String imei, String typeCommand) async {
    var url = "http://159.89.83.60:8082/command/testing";
    var headData = {HttpHeaders.contentTypeHeader: "application/json"};
    var data = {"deviceId": deviceId, "uniqueId": imei, "type": typeCommand};
    var bodyData = jsonEncode(data);
    final response = await client.post(Uri.parse(url), headers: headData, body: bodyData);
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}