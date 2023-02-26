// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:ubik_gps_application_flutter/icons/icon_create.dart';
import 'package:ubik_gps_application_flutter/src/constants/constanst.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_ubik.dart';
import 'package:ubik_gps_application_flutter/src/models/sharedPreferencesClass.dart';

class MapOpenStreet extends StatefulWidget {
  const MapOpenStreet({Key key}) : super(key: key);

  @override
  MapOpenStreetState createState() => MapOpenStreetState();
}

class MapOpenStreetState extends State<MapOpenStreet> {
  LatLong point = LatLong(-2.150430, -79.893929);

  //LatLong point = LatLong(-2.150430, -79.893929);
  double lat, lon;
  String _currentAddress;
  Position _currentPosition;
  LatLng punto, user;
  bool isVisible = false;
  bool blockDoor = false;
  bool blockCar = false;
  List<String> door = ["Abrir Puertas", "Cerrar Puertas"];
  List<String> car = ["Bloqueo encendido", "Bloqueo Apagado"];
  ApiUbik ubik = ApiUbik();
  MapController mapController;
  UserPreferences userPreferences;

  Future<void> coordinates() async {
    final latitude = await userPreferences.getLatitude();
    final longitude = await userPreferences.getLongitude();

    setState(() {
      lat = latitude;
      lon = longitude;
    });
  }

  @override
  void initState() {
    _getCurrentPosition();
    _getCurrentLocation();
    mapController = MapController();
    super.initState();
  }

  Future<bool> _locationPermition() async {
    bool serviceEnable;
    LocationPermission permission;

    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Servicio de localizacion deshabilitados, por favor Active el GPS e intente nuevamente"),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: 30),
      ));
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Permisos de localizacion denegados"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: 30),
        ));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Permisos de localizacion han sido denegados permanentemente, no se pude volver a consultar el permiso"),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: 30),
      ));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _locationPermition();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
      setState(() {
        user = LatLng(position.latitude, position.longitude);
        _currentPosition = position;
      });
      _getAddressPosition(_currentPosition);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressPosition(Position position) async {
    await placemarkFromCoordinates(_currentPosition.latitude, _currentPosition.longitude).then((List<Placemark> placemark) {
      Placemark place = placemark[0];
      setState(() {
        _currentAddress = "${place.street}, ${place.subLocality}, ${place.locality}, ${place.country}";
        print(_currentAddress);
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getCurrentLocation() async {
    final hasPermission = await _locationPermition();
    if (!hasPermission) return;
    var url = "http://159.89.83.60:8082/position/343";
    final response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if(response.statusCode == 200){
      setState(() {
        punto = LatLng(jsonData['response']['latitude'], jsonData['response']['longitude']);
        _currentPosition = Position(longitude: punto.longitude, latitude: punto.latitude);
        _getAddressPosition(_currentPosition);
      });
    }
    else{
      return;
    }
  }

  static final DateTime now = DateTime.now();
  //Location locationData;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: mapController,
          options: MapOptions(
            zoom: 16,
            maxZoom: 18.25,
            minZoom: 15,
            center: punto ?? user,
          ),
          children: [
            TileLayer(urlTemplate: AppConstants.urlOpenStreetMap, subdomains: const ['a', 'b', 'c']),
            MarkerLayer(markers: [
              Marker(
                width: 40,
                height: 40,
                point: punto,
                builder: (ctx) => const Icon(
                  Icomoon.carUbik,
                  color: Colors.red,
                  size: 40,
                ),
              ),
              Marker(
                width: 40,
                height: 40,
                point: user,
                builder: (ctx) => const Icon(
                  Icomoon.personLocation,
                  color: Colors.red,
                  size: 40,
                ),
              )
            ]),
          ],
        ),//map Open Street Map
        Positioned(
            top: MediaQuery.of(context).size.height * 0.005,
            left: MediaQuery.of(context).size.width * 0.7,
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.15,
                  left: MediaQuery.of(context).size.width * 0.08,
                  right: MediaQuery.of(context).size.width * 0.08),
              child: FloatingActionButton(elevation: 10, onPressed: () {}, child: const Icon(Icomoon.mapLocation, size: 40)),
            )), //widget map
        Positioned(
            top: MediaQuery.of(context).size.height * 0.08,
            left: MediaQuery.of(context).size.width * 0.7,
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.15,
                  left: MediaQuery.of(context).size.width * 0.08,
                  right: MediaQuery.of(context).size.width * 0.08),
              child: FloatingActionButton(elevation: 10, onPressed: () {}, child: const Icon(Icomoon.trafficLight, size: 40)),
            )),
      ],
    );
  }
}