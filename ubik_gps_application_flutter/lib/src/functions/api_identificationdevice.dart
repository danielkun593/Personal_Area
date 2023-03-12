import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiIdentificationDevice{

  //GET IMEI DEVICE USER
  Future<String> getImei(http.Client client, String token, int deviceID)async{
    String imei;
    var urlDevice = "http://159.89.83.60:8080/Devices/get_devices/$deviceID";
    var dataHeader = {HttpHeaders.authorizationHeader: "Bearer $token"};
    final response = await client.get(Uri.parse(urlDevice), headers: dataHeader);
    var jsonData = jsonDecode(response.body);
    imei = jsonData['response'];
    return imei;
  }
}