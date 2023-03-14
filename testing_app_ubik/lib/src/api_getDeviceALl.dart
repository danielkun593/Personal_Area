import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:testing_app_ubik/src/getAllDevice.dart';

class ApiDeviced{

  //GET DEVICES USER
  Future<List<AllDevice>> getAllDevice(http.Client client, String token)async{
    List<AllDevice> listDevice = [];
    var urlDevice = "http://159.89.83.60:8080/Devices/get_devices";
    var dataHeader = {HttpHeaders.authorizationHeader: "Bearer $token"};
    final response = await http.get(Uri.parse(urlDevice), headers: dataHeader);
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      for(var d in jsonData['response']){
        listDevice.add(AllDevice(d));
      }
    }
    return listDevice;
  }

  //GET DEVICES USER
  Future<List<String>> getFirstDevice(http.Client client, String token)async{
    List<String> listString = [];
    var urlDevice = "http://159.89.83.60:8080/Devices/get_devices";
    var dataHeader = {HttpHeaders.authorizationHeader: "Bearer $token"};
    final response = await http.get(Uri.parse(urlDevice), headers: dataHeader);
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      for(var i in jsonData['response']){
        listString.add(i);
      }
      return listString;
    }
  }
}