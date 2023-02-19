import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:jsonapp/class/photoClass.dart';

class Conexion{
 Future<List<Photo>> fetchPhoto(http.Client client) async{
  var url = "https://jsonplaceholder.typicode.com/photos";
  final response = await client.get(Uri.parse(url));
  //return parsePhotos(response.body);
  return compute(parsePhotos, response.body);
 }

 List<Photo> parsePhotos (String responseBody){
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Photo>((json)=> Photo.fromJson(json)).toList();
 }
}