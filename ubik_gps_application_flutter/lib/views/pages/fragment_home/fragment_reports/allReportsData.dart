// ignore_for_file: camel_case_types, missing_required_param, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:ubik_gps_application_flutter/components/buttonDesign.dart';
import 'package:ubik_gps_application_flutter/components/decorationBackground.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_devicelist.dart';
import 'package:ubik_gps_application_flutter/src/models/deviceClass.dart';
import 'package:ubik_gps_application_flutter/views/pages/fragment_home/fragment_reports/options_report/abstractData.dart';
import 'package:ubik_gps_application_flutter/views/pages/fragment_home/fragment_reports/options_report/reportsData.dart';

class allReport extends StatefulWidget {
  const allReport({Key key, @required this.token}) : super(key: key);

  final String token;

  @override
  allReportState createState() => allReportState();
}

class allReportState extends State<allReport> {
  String _currentAddress;
  ApiDevice deviceApi = ApiDevice();

  _directionSingle(double latitude, double longitude)async{
    List<Placemark> placemark = await placemarkFromCoordinates(latitude, longitude);
    _currentAddress = "${placemark[0].street}; ${placemark[0].country}; ${placemark[0].administrativeArea}";
    print(_currentAddress);
    return _currentAddress;
  }


  @override
  void initState(){
    super.initState();
    _directionSingle(47.5951518,-122.3316393);

  }

  List<Widget> listDispositivos(List<Device> data, String address){
    List<Widget> listWidget = [];
    for (var item in data) {
      listWidget.add(SizedBox(
          height: 200,
          width: 400,
          child: Column(
            children: [
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const SizedBox(width: 30),
                        const Icon(Icons.person),
                        const SizedBox(width: 20),
                        Text(item.name_user),
                        SizedBox(width: MediaQuery.of(context).size.width*0.3),
                        item.statusDevice == 'online' ? const Icon(Icons.circle, color: Colors.green) :
                        item.statusDevice == 'offline' ? const Icon(Icons.circle, color: Colors.red) : const Icon(Icons.circle, color: Colors.black),
                        const SizedBox(width: 10),
                        Text(item.statusDevice),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 30),
                        const Icon(Icons.car_rental),
                        const SizedBox(width: 20),
                        Text('Velocidad: ${item.speed.toString()} KM'),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 30),
                        const Icon(Icons.calendar_month),
                        const SizedBox(width: 20),
                        Text("Ultimo tiempo activo: ${item.device_time}")
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 30),
                        const Icon(Icons.location_city),
                        const SizedBox(width: 20),
                        Text("Locations: ${item.latitude}; ${item.longitude}"),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                ButtonWidget(
                  function: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const abstractData()));
                  },
                  namebutton: "RESUMEN",
                  color: Colors.red,
                  circular: 5,
                  width: 20,
                  height: 10,
                ),
                const SizedBox(width: 5),
                ButtonWidget(
                  function: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const reportData()));
                  },
                  namebutton: "REPORTES",
                  color: Colors.red,
                  circular: 5,
                  width: 20,
                  height: 10,
                )
              ])
            ],
          )));
    }
    return listWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: DecorationBack.backgroundGradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<List<Device>>(
              future: deviceApi.deviceUser(http.Client(), widget.token),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                      children: listDispositivos(snapshot.data, _currentAddress)
                  );
                } else if (snapshot.hasError) {
                  return Container();
                }
                return const Center(child: CircularProgressIndicator());
              }),
        ),
      ),
    );
  }
}