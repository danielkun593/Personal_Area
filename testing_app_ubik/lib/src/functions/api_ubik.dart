// ignore_for_file: deprecated_member_use, avoid_print, missing_return
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toast/toast.dart';

class ApiUbik {

  //SEND COMMANDS ENDPOINT  UBIK SERVER COMUN
  Future<bool> commandSend(http.Client client, int deviceId, String imei, String typeCommand) async {
    var url = "http://159.89.83.60:8082/command/send";
    var headData = {HttpHeaders.contentTypeHeader: "application/json"};
    var data = {"deviceId": deviceId, "uniqueId": imei, "type": typeCommand};
    var bodyData = jsonEncode(data);
    final response = await client.post(Uri.parse(url), headers: headData, body: bodyData);
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode != 200) {
      return false;
    }
  }

  Future<LatLng> lastPositionSingle(http.Client client, int deviceId, String imei, String typeCommand) async {
    LatLng latLng;
    var url = "http://159.89.83.60:8082/command/send";
    var headData = {HttpHeaders.contentTypeHeader: "application/json"};
    var data = {"deviceId": deviceId, "uniqueId": imei, "type": typeCommand};
    var bodyData = jsonEncode(data);
    final response = await client.post(Uri.parse(url), headers: headData, body: bodyData);
    var jsonData = jsonDecode(response.body);
    print(jsonData['response']);
    if(response.statusCode == 200){
      for(var i in jsonData['response']){
        latLng = LatLng(i['latitude'], i['longitude']);
      }
      return latLng;
    }else if(response.statusCode != 200){
      return null;
    }
  }

  Future<void> positionSingle(http.Client client, int device, String imei, BuildContext context)async{
    try{
      //https://www.google.com/maps/search/?api=1&query=47.5951518,-122.3316393'
      var url = "http://159.89.83.60:8082/command/send";
      var headData = {HttpHeaders.contentTypeHeader: "application/json"};
      var data = {"deviceId": device, "uniqueId": imei, "type": "positionSingle"};
      var bodyData = jsonEncode(data);
      final response = await client.post(Uri.parse(url), headers: headData, body: bodyData);
      final jsonData = jsonDecode(response.body);
      print(response.body);
      if(response.statusCode == 200){
        var url = Uri.parse("https://www.google.com/maps/search/?api=1&query=${jsonData['response'][0]['latitude']},${jsonData['response'][0]['longitude']}");
        Share.share(url.toString());
      }else{
        var url = "http://159.89.83.60:8082/position/$device";
        final response = await client.get(Uri.parse(url));
        print(response.body);
        final jsonData = jsonDecode(response.body);
        var urlGoogleMap = Uri.parse("https://www.google.com/maps/search/?api=1&query=${jsonData['response'][0]['latitude']},${jsonData['response'][0]['longitude']}");
        Share.share(urlGoogleMap.toString());
      }
    }catch(e){
      print(e);
      ToastContext().init(context);
      Toast.show(e.toString(), gravity: Toast.bottom, duration: Toast.lengthLong);
    }
  }
}