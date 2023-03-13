import 'dart:io';
import 'package:http/http.dart' as http;

class ApiRegister{
  //
  Future<bool> setUser(String name, String phone, String email, String password)async{
    var url = "http://159.89.83.60:8080/Users";
    var dataBody={
      "name": name, "email": email,
      "hashedpassword": password, "salt": null,
      "readonly": false, "administrator": false, "map": null,
      "latitude": 0.0, "longitude": 0.0,
      "zoom": 0, "twelvehourformat": false,
      "attributes": "attribute1", "coordinateformat": "coordinateformat1",
      "disabled": false, "expirationtime": null,
      "devicelimit": 1, "token": null,
      "userlimit": 0, "devicereadonly": false,
      "phone": phone, "limitcommands": false,
      "login": "login", "poilayer": null, "planid": 2
    };
    var dataHeader = {HttpHeaders.contentTypeHeader: "application/json"};
    final response = await http.post(Uri.parse(url), headers: dataHeader, body: dataBody);
    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }
}