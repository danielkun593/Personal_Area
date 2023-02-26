// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  //NAME KEY THE METHODS APPLICATIONS IN DEPENDENCIES SHARED PREFERENCES
  String tc_id = 'id';
  String tc_name = 'name';
  String tc_email = 'email';
  String tc_password = 'password';
  String tc_phone = 'phone';
  String tc_plan = 'plan';
  String tc_cost_plan = 'cost_plan';
  String tc_notification = 'notification';
  String tc_device = 'device';
  String latitud = 'latitud';
  String longitud = 'longitud';
  String tc_token = 'token';
  String cookie = 'cookie';

  //|==================================================|
  //|=====METHODS SET SHARED PREFERENCES USER DATA=====|
  //|==================================================|

  setId(int userId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt(tc_id, userId);
  }

  setCostPlan(String costPlan) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(tc_cost_plan, costPlan);
  }

  setCantNotify(int cantNotify) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt(tc_notification, cantNotify);
  }

  setDevice(List<dynamic> device) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setStringList(tc_device, device);
  }

  setName(String nameUser) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(tc_name, nameUser);
  }

  setTypePlan(String typePlan) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(tc_plan, typePlan);
  }

  setEmail(String emailUser) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(tc_email, emailUser);
  }

  setPassword(String passwordUser) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(tc_password, passwordUser);
  }

  setPhone(String phoneUser) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(tc_phone, phoneUser);
  }

  setLatitude(double latitudUser) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setDouble(latitud, latitudUser);
  }

  setLongitude(double longitudUser) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setDouble(longitud, longitudUser);
  }

  setToken(String tokenUser) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(tc_token, tokenUser);
  }

  setCookie(String cookieUser) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(cookie, cookieUser);
  }

  //|==================================================|
  //|=====METHODS GET SHARED PREFERENCES USER DATA=====|
  //|==================================================|

  Future<int> getID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final resultId = preferences.getInt(tc_id);
    return resultId;
  }

  Future<int> getCostPlan() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final resultCostPlan = preferences.getInt(tc_cost_plan);
    return resultCostPlan;
  }

  Future<int> getCantNotification() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final resultNotify = preferences.getInt(tc_notification);
    return resultNotify;
  }

  Future<List<dynamic>> getDevice() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final resultDevice = preferences.getStringList(tc_device);
    return resultDevice;
  }

  Future<String> getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final resultName = preferences.getString(tc_name);
    return resultName;
  }

  Future<String> getPlanUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final resultPlan = preferences.getString(tc_plan);
    return resultPlan;
  }

  Future<String> getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final resultEmail = preferences.getString(tc_email);
    return resultEmail;
  }

  Future<String> getPassword() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final resultPassword = preferences.getString(tc_password);
    return resultPassword;
  }

  Future<String> getPhone() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final resultPhone = preferences.getString(tc_phone);
    return resultPhone;
  }

  Future<double> getLatitude() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final resultLatitud = preferences.getDouble(latitud);
    return resultLatitud;
  }

  Future<double> getLongitude() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final resultLongitud = preferences.getDouble(longitud);
    return resultLongitud;
  }

  Future<String> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final resultToken = preferences.getString(tc_token);
    return resultToken;
  }

  Future<String> getCookie() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final resultCookie = preferences.getString(cookie);
    return resultCookie;
  }
}
