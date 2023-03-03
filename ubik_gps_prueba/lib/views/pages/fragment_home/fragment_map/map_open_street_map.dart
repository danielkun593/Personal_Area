// ignore_for_file: use_build_context_synchronously, missing_required_param, avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:ubik_gps_application_flutter/icons/icon_create.dart';
import 'package:ubik_gps_application_flutter/src/constants/constanst.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_ubik.dart';
import 'package:ubik_gps_application_flutter/src/models/sharedPreferencesClass.dart';

class MapParking extends StatefulWidget {
  const MapParking({Key key}) : super(key: key);

  @override
  MapParkingState createState() => MapParkingState();
}

class MapParkingState extends State<MapParking> {
  //LatLong point = LatLong(-2.150430, -79.893929);
  double lat, lon;
  String _currentAddress;
  Position _currentPosition;
  LatLng punto, user, center;
  bool isVisible = false;
  bool blockDoor = false;
  bool blockCar = false;
  List<String> door = ["Abrir Puertas", "Cerrar Puertas"];
  List<String> car = ["Bloqueo encendido", "Bloqueo Apagado"];
  ApiUbik ubik = ApiUbik();
  MapController mapController;


  @override
  void initState() {
    super.initState();
    mapController = MapController();
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

  Future<LatLng> _getCurrentLocation(http.Client client) async {
    await Future.delayed(const Duration(seconds: 1));
    var url = "http://159.89.83.60:8082/position/343";
    final response = await client.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if(response.statusCode == 200){
      setState(() {
        punto = LatLng(jsonData['response']['latitude'], jsonData['response']['longitude']);
        _currentPosition = Position(longitude: punto.longitude, latitude: punto.latitude);
        _getAddressPosition(_currentPosition);
      });
    }
    return punto;
  }

  mapFlutter(LatLng data, String address, DateTime time, MapController mapController){
    Widget map;
    map = Stack(
      children: [
        FlutterMap(
          mapController: mapController,
          options: MapOptions(
              zoom: 16,
              maxZoom: 18.25,
              minZoom: 15,
              center: LatLng(data.latitude, data.longitude)
          ),
          children: [
            TileLayer(urlTemplate: AppConstants.urlOpenStreetMap, subdomains: const ['a', 'b', 'c']),
            MarkerLayer(markers: [
              Marker(
                width: 40,
                height: 40,
                point: data,
                builder: (ctx) => const Icon(
                  Icomoon.carUbik,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ]),
          ],
        ),//map Open Street Map
        Positioned(
            top: MediaQuery.of(context).size.height * 0.004,
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.15,
                  left: MediaQuery.of(context).size.width * 0.08,
                  right: MediaQuery.of(context).size.width * 0.08),
              child: FloatingActionButton(elevation: 10, onPressed: () {}, child: const Icon(Icomoon.reload, size: 40)),
            )), //widget reload
        Positioned(
            top: MediaQuery.of(context).size.height * 0.075,
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.15,
                  left: MediaQuery.of(context).size.width * 0.08,
                  right: MediaQuery.of(context).size.width * 0.08),
              child: FloatingActionButton(
                  elevation: 10,
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  child: isVisible == false ? const Icon(Icomoon.dataIcon, size: 35) : const Icon(Icons.close_sharp, size: 35)),
            )),
        Positioned(
            top: MediaQuery.of(context).size.height * 0.005,
            left: MediaQuery.of(context).size.width * 0.7,
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.15,
                  left: MediaQuery.of(context).size.width * 0.08,
                  right: MediaQuery.of(context).size.width * 0.08),
              child: FloatingActionButton(elevation: 10, onPressed: () {}, child: const Icon(Icons.circle_outlined, size: 40)),
            )), //widget map
        Positioned(
            top: MediaQuery.of(context).size.height * 0.08,
            left: MediaQuery.of(context).size.width * 0.7,
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.15,
                  left: MediaQuery.of(context).size.width * 0.08,
                  right: MediaQuery.of(context).size.width * 0.08),
              child: FloatingActionButton(elevation: 10, onPressed: () {}, child: const Icon(Icons.square_outlined, size: 40)),
            )), //widget change to route map
        Positioned(
            top: MediaQuery.of(context).size.height * 0.16,
            left: MediaQuery.of(context).size.width * 0.7,
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.15,
                  left: MediaQuery.of(context).size.width * 0.08,
                  right: MediaQuery.of(context).size.width * 0.08),
              child: FloatingActionButton(
                  elevation: 10,
                  onPressed: (){
                    _getCurrentLocation(http.Client());
                    mapController.move(data, 16);
                  },
                  child: const Icon(Icons.gps_fixed_outlined, size: 40)),
            )), //widget set and get current location
        Positioned(
            height: 380,
            top: MediaQuery.of(context).size.height * 0.52,
            right: MediaQuery.of(context).size.width * 0.02,
            left: MediaQuery.of(context).size.width * 0.02,
            child: Visibility(
              visible: isVisible,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          const CircleAvatar(
                            radius: 30,
                            child: Icon(Icons.person, size: 40),
                          ),
                          Column(
                            children: const <Widget>[Icon(Icons.circle, color: Colors.green), Text("")],
                          ),
                          Column(
                            children: const [
                              Text("Online DON ARTURO", style: TextStyle(fontSize: 20)),
                              SizedBox(height: 5),
                              Text("10km/h"),
                            ],
                          ),
                          const SizedBox(width: 45),
                          const Icon(Icomoon.sharedOutline, size: 45, color: Colors.red),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: <Widget>[
                          const SizedBox(width: 25),
                          const Icon(Icons.location_on_outlined, color: Colors.green),
                          Text(address ?? "Cargando...", style: const TextStyle(fontSize: 20), softWrap: true),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: <Widget>[
                          const SizedBox(width: 25),
                          const Icon(Icons.date_range_outlined, color: Colors.green),
                          Text("${time.day}/${time.month}/${time.year}   ${time.hour}:${time.minute}",
                              style: const TextStyle(fontSize: 20), softWrap: true),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            Text("Comandos", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), softWrap: true),
                            Icon(Icons.arrow_forward_rounded, color: Colors.green),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05),
                          child: Row(
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: Colors.green),
                                child: SizedBox(
                                  width: 85,
                                  height: 50,
                                  child: Row(
                                    children: const [
                                      Expanded(child: Icon(Icons.location_on, color: Colors.red)),
                                      SizedBox(width: 5),
                                      Expanded(
                                          flex: 2,
                                          child: Text('Solicitar Ubicacion',
                                              softWrap: true, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    blockCar = !blockCar;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: blockCar == false ? Colors.green : Colors.red //const Color.fromRGBO(76, 142, 48, 20)
                                ),
                                child: SizedBox(
                                  width: 85,
                                  height: 50,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: blockCar == false
                                              ? const Icon(Icons.lock, color: Colors.red)
                                              : const Icon(Icons.lock_open, color: Colors.white)),
                                      const SizedBox(width: 5),
                                      Expanded(
                                          flex: 3,
                                          child: Text(blockCar == false ? car[0] : car[1],
                                              softWrap: true, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    blockDoor = !blockDoor;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: blockDoor == false ? Colors.green : Colors.red),
                                child: SizedBox(
                                  width: 85,
                                  height: 50,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: blockDoor == false
                                              ? const Icon(Icomoon.openDoorCar, color: Colors.red)
                                              : const Icon(Icomoon.openDoorCar, color: Colors.white)),
                                      const SizedBox(width: 5),
                                      Expanded(
                                          flex: 2,
                                          child: Text(blockDoor == false ? door[0] : door[1],
                                              softWrap: true, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))),
                          ),
                          child: Container(
                            width: 80,
                            height: 40,
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.02, right: MediaQuery.of(context).size.width * 0.02),
                            child: const Center(child: Text("RESUMEN")),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15))),
                          ),
                          child: Container(
                            width: 80,
                            height: 40,
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.02, right: MediaQuery.of(context).size.width * 0.02),
                            child: const Center(child: Text("REPORTES")),
                          ),
                        ),
                      ])
                    ],
                  ),
                ),
              ),
            )), //widget Card data users
      ],
    );
    return map;//map Open Street Map
  }

  static final DateTime now = DateTime.now();
  //Location locationData;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getCurrentLocation(http.Client()),
        builder: (ctx, snapshot){
          if(snapshot.hasData){
            return mapFlutter(snapshot.data, _currentAddress, now, mapController);
          }
          else if(snapshot.hasError){
            return Container();
          }
          return Center(child: CircularProgressIndicator());
        }
    );
  }
}
