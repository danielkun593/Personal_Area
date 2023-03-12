// ignore_for_file: use_build_context_synchronously, missing_required_param, avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toast/toast.dart';
import 'package:ubik_gps_application_flutter/components/buttonIconDesign.dart';
import 'package:ubik_gps_application_flutter/components/buttonIconDesign2.dart';
import 'package:ubik_gps_application_flutter/icons/icon_create.dart';
import 'package:ubik_gps_application_flutter/src/constants/constanst.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_device.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_identificationdevice.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_ubik.dart';
import 'package:ubik_gps_application_flutter/src/models/getDeviceUser.dart';
import 'package:ubik_gps_application_flutter/views/pages/fragment_home/fragment_reports/options_report/abstractData.dart';
import 'package:ubik_gps_application_flutter/views/pages/fragment_home/fragment_reports/options_report/reportsData.dart';

class MapGps extends StatefulWidget {
  const MapGps({Key key, @required this.token}) : super(key: key);

  final String token;

  @override
  MapGpsState createState() => MapGpsState();
}

class MapGpsState extends State<MapGps> {
  //LatLong point = LatLong(-2.150430, -79.893929);
  double lat, lon;
  String _currentAddress;
  Position _currentPosition;
  LatLng punto, user;
  bool isVisible = false;
  bool isVisibleCard = true;
  bool blockDoor = false;
  bool blockCar = false;
  bool statusCommand;
  int device;
  List<String> door = ["Abrir Puertas", "Cerrar Puertas"];
  List<String> car = ["Bloqueo Activado", "Bloqueo Desactivado"];
  List<AllDevice> listDevicesAll; // list class device
  List<String> deviceItemList =[]; //convert future to string for dropdownbutton
  ApiUbik connectService = ApiUbik();
  ApiDeviced deviced = ApiDeviced();
  ApiIdentificationDevice identificationDevice = ApiIdentificationDevice();
  MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    listDispositivos(deviced.getAllDevice(http.Client(), widget.token));
    deviceItemList.map((e){
      device = int.parse(e);
    });
  }

  void listDispositivos(Future<List<AllDevice>> data)async{
    listDevicesAll = await data;
    for(int x=0; x<listDevicesAll.length; x++){
      deviceItemList.add(listDevicesAll[x].deviceId);
    }
  }//Function Convert Future<list> to List

  Future<void> _getAddressPosition(Position position) async {
    await placemarkFromCoordinates(_currentPosition.latitude, _currentPosition.longitude).then((List<Placemark> placemark) {
      Placemark place = placemark[0];
      setState(() {
        _currentAddress = "${place.street}, ${place.subLocality}, ${place.locality}";
        print(_currentAddress);
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }
  Future<LatLng> _getCurrentLocation(http.Client client) async {
    await Future.delayed(const Duration(seconds: 1));
    var url = "http://159.89.83.60:8082/position/340";
    final response = await client.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if(response.statusCode == 200){
      setState(() {
        punto = LatLng(jsonData['response'][0]['latitude'], jsonData['response'][0]['longitude']);
        _currentPosition = Position(longitude: punto.longitude, latitude: punto.latitude);
        _getAddressPosition(_currentPosition);
      });
    }
    return punto;
  }
  Future<void> positionSingle(http.Client client, int device, String imei, String command)async{
    try{
      //https://www.google.com/maps/search/?api=1&query=47.5951518,-122.3316393'
      LatLng locationPointer = await connectService.lastPositionSingle(client, device, imei, command);
      if(locationPointer != null){
        var url = Uri.parse("https://www.google.com/maps/search/?api=1&query=${locationPointer.latitude},${locationPointer.longitude}");
        Share.share(url.toString());
      }else if(locationPointer == null){
        var url = "http://159.89.83.60:8082/position/343";
        final response = await client.get(Uri.parse(url));
        var jsonData = jsonDecode(response.body);
        var urlGoogleMap = Uri.parse("https://www.google.com/maps/search/?api=1&query=${jsonData['response']['latitude']},${jsonData['response']['longitude']}");
        Share.share(urlGoogleMap.toString());
      }
    }catch(e){
      ToastContext().init(context);
      Toast.show(e.toString(), gravity: Toast.bottom, duration: Toast.lengthLong);
    }
  }
  Future<void> sendCommand(http.Client client, int device, String imei, String command, bool status)async{
    try{
      statusCommand = await connectService.commandSend(client, device, imei, command);
      if(statusCommand == true){
        ToastContext().init(context);
        Toast.show("OK, Listo.", gravity: Toast.bottom, duration: Toast.lengthLong);
        status = true;
        print(statusCommand);
      }else{
        ToastContext().init(context);
        Toast.show("Accion no procesada. Intentelo mas tarde", gravity: Toast.bottom, duration: Toast.lengthLong);
        status = false;
        print(statusCommand);
      }
    }catch(e){
      ToastContext().init(context);
      Toast.show(e.toString(), gravity: Toast.bottom, duration: Toast.lengthLong);
    }
  }

  static final DateTime now = DateTime.now();
  mapFlutter(LatLng data, String address, DateTime time, MapController mapController, int deviceList){
    Widget map;
    map = Stack(
      children: [
        FlutterMap(
          mapController: mapController,
          options: MapOptions(
            zoom: 16,
            maxZoom: 18.25,
            minZoom: 15,
            center: data,
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
              child: FloatingActionButton(
                  elevation: 10,
                  onPressed: () {
                    isVisibleCard = !isVisibleCard;
                  },
                  child: isVisibleCard == true ? const Icon(Icons.visibility, size: 40) : const Icon(Icons.visibility_off, size: 40)
              ),
            )), //widget reload
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
            )), //widget change to route map
        Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.width * 0.7,
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.15,
                  left: MediaQuery.of(context).size.width * 0.08,
                  right: MediaQuery.of(context).size.width * 0.08),
              child: FloatingActionButton(elevation: 10, onPressed: () {
                //_getCurrentPosition();
                //mapController.move(user, 13);
              }, child: const Icon(Icomoon.personLocation, size: 40)),
            )), //widget change to see map
        Positioned(
            height: 340,
            top: MediaQuery.of(context).size.height * 0.56,
            right: MediaQuery.of(context).size.width * 0.10,
            left: MediaQuery.of(context).size.width * 0.10,
            child: Visibility(
              visible: isVisible,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                child: Container(
                  padding: const EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          const CircleAvatar(
                            radius: 20,
                            child: Icon(Icons.person, size: 40),
                          ),
                          const Icon(Icons.circle, color: Colors.green),
                          Column(
                            children: const [
                              Text("DON ARTURO", style: TextStyle(fontSize: 20)),
                              SizedBox(height: 5),
                              Text("10km/h"),
                            ],
                          ),
                          ButtonIconWidget(
                            function: ()async{
                              ToastContext().init(context);
                              Toast.show("Preparando dispositivo para compartir ubicacion", gravity: Toast.bottom, duration: Toast.lengthLong);
                              int deviceId = int.parse("340");
                              String imei = await identificationDevice.getImei(http.Client(), widget.token, deviceId);
                              connectService.positionSingle(http.Client(), deviceId, imei, context);
                              print(deviceId);
                            },
                            iconData: Icons.share,
                            namebutton: "",
                            color: Colors.red,
                            size: 25,
                            circular: 10,
                          ),
                          ButtonIconWidget(
                            function: (){
                              setState(() {
                                isVisible = !isVisible;
                                isVisibleCard = !isVisibleCard;
                              });
                            },
                            iconData: Icons.close,
                            namebutton: "",
                            color: Colors.red,
                            size: 25,
                            circular: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            fit: FlexFit.loose,
                            child: Container(
                              padding: const EdgeInsets.only(top: 5, right: 0, left: 10, bottom: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  const Icon(Icons.location_on_outlined, color: Colors.green),
                                  Expanded(child: Text(address ?? "Cargando...", style: const TextStyle(fontSize: 18), softWrap: false, overflow: TextOverflow.ellipsis, maxLines: 2)),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.loose,
                            child: Container(
                              padding: const EdgeInsets.only(top: 5, right: 0, left: 15, bottom: 0),
                              child: Row(
                                children: <Widget>[
                                  const Icon(Icons.date_range_outlined, color: Colors.green),
                                  Expanded(
                                    child: Text("${time.day}/${time.month}/${time.year}   ${time.hour}:${time.minute}",
                                        style: const TextStyle(fontSize: 18), softWrap: false, overflow: TextOverflow.ellipsis, maxLines: 4),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
                      Column(
                        children: [
                          ButtonIconWidget2(
                            function: (){
                              _getCurrentLocation(http.Client());
                              mapController.move(data, 16);
                            },
                            namebutton: "Solicitar ubicacion",
                            color: Colors.green,
                            circular: 15,
                            height: 55,
                            width: 190,
                            icon: const Icon(Icons.location_on),
                          ),
                          const SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05),
                              child: Row(
                                children: <Widget>[
                                  ButtonIconWidget2(
                                    function: ()async{
                                      setState(() {
                                        blockCar =! blockCar;
                                      });
                                      ToastContext().init(context);
                                      Toast.show("Preparando dispositivo para compartir ubicacion", gravity: Toast.bottom, duration: Toast.lengthLong);
                                      int deviceId = int.parse("340");
                                      String imei = await identificationDevice.getImei(http.Client(), widget.token, deviceId);
                                      String commandEnc = "engineResume";
                                      String commandApa = "engineStop";
                                      statusCommand = await connectService.commandSend(http.Client(), deviceId, imei, blockDoor == false ? commandEnc : commandApa);
                                      print(blockDoor == false ? commandEnc : commandApa);
                                      try{
                                        if (statusCommand == true) {
                                          ToastContext().init(context);
                                          Toast.show("OK, Listo.", gravity: Toast.bottom, duration: Toast.lengthLong);
                                          setState(() {
                                            blockDoor == true;
                                          });
                                          //print(statusCommand);
                                        } else if (statusCommand == false) {
                                          ToastContext().init(context);
                                          Toast.show("Dispositivo desconectado", gravity: Toast.bottom, duration: Toast.lengthLong);
                                          setState(() {
                                            blockDoor == false;
                                          });
                                          //print(statusCommand);
                                        }
                                      }catch(e){
                                        ToastContext().init(context);
                                        Toast.show(e.toString(), gravity: Toast.bottom, duration: Toast.lengthLong);
                                      }
                                    },
                                    namebutton: blockCar == false ? car[0] : car[1],
                                    color: blockCar == false ? Colors.green : Colors.red,
                                    circular: 10,
                                    height: 50,
                                    width: 95,
                                    icon: blockCar == false
                                        ? const Icon(Icons.lock, color: Colors.red)
                                        : const Icon(Icons.lock_open, color: Colors.white),
                                  ),
                                  const SizedBox(width: 10),
                                  ButtonIconWidget2(
                                    function: ()async{
                                      setState(() {
                                        blockDoor =! blockDoor;
                                      });
                                      ToastContext().init(context);
                                      Toast.show("Preparando dispositivo para compartir ubicacion", gravity: Toast.bottom, duration: Toast.lengthLong);
                                      int deviceId = int.parse("343");
                                      String imei = await identificationDevice.getImei(http.Client(), widget.token, deviceId);
                                      String commandDis = "alarmDisarm";
                                      String commandArm = "alarmArm";
                                      statusCommand = await connectService.commandSend(http.Client(), deviceId, imei, blockDoor == false ? commandArm : commandDis);
                                      print(blockDoor == false ? commandArm : commandDis);
                                      try{
                                        if (statusCommand == true) {
                                          ToastContext().init(context);
                                          Toast.show("OK, Listo.", gravity: Toast.bottom, duration: Toast.lengthLong);
                                          setState(() {
                                            blockDoor == true;
                                          });
                                          //print(statusCommand);
                                        } else if (statusCommand == false) {
                                          ToastContext().init(context);
                                          Toast.show("Dispositivo desconectado", gravity: Toast.bottom, duration: Toast.lengthLong);
                                          setState(() {
                                            blockDoor == false;
                                          });
                                          //print(statusCommand);
                                        }
                                      }catch(e){
                                        ToastContext().init(context);
                                        Toast.show(e.toString(), gravity: Toast.bottom, duration: Toast.lengthLong);
                                      }
                                    },
                                    namebutton: blockDoor == false ? door[0] : door[1],
                                    color: blockDoor == false ? Colors.green : Colors.red,
                                    circular: 10,
                                    height: 50,
                                    width: 95,
                                    icon: blockDoor == false
                                        ? const Icon(Icomoon.openDoorCar, color: Colors.red)
                                        : const Icon(Icomoon.openDoorCar, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const abstractData()));
                          },
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
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const reportData()));
                          },
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
        Positioned(
            top: MediaQuery.of(context).size.height * 0.75,
            bottom: MediaQuery.of(context).size.height * 0.1,
            left: MediaQuery.of(context).size.height * 0,
            right: MediaQuery.of(context).size.height * 0,
            child: Visibility(
              visible: isVisibleCard,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: cardDevice(deviceList, address, time, data),
                  ),
                ),
              ),
            )
        ),

      ],
    );
    return map;//map Open Street Map
  }
  List<Widget> cardDevice(int data, String address, DateTime time, LatLng point){
    List<Widget> cardDevice = [];
    cardDevice.add(
      SizedBox(
        height: 140,
        width: 250,
        child: InkWell(
          onTap: (){
            setState(() {
              isVisible = !isVisible;
              isVisibleCard = !isVisibleCard;
            });
            Positioned(
                height: 340,
                top: MediaQuery.of(context).size.height * 0.56,
                right: MediaQuery.of(context).size.width * 0.10,
                left: MediaQuery.of(context).size.width * 0.10,
                child: Visibility(
                  visible: isVisible,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    child: Container(
                      padding: const EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              const CircleAvatar(
                                radius: 20,
                                child: Icon(Icons.person, size: 40),
                              ),
                              const Icon(Icons.circle, color: Colors.green),
                              Column(
                                children: const [
                                  Text("DON ARTURO", style: TextStyle(fontSize: 20)),
                                  SizedBox(height: 5),
                                  Text("10km/h"),
                                ],
                              ),
                              ButtonIconWidget(
                                function: ()async{
                                  ToastContext().init(context);
                                  Toast.show("Preparando dispositivo para compartir ubicacion", gravity: Toast.bottom, duration: Toast.lengthLong);
                                  String command = "positionSingle";
                                  int deviceId = int.parse("343");
                                  String imei = await identificationDevice.getImei(http.Client(), widget.token, deviceId);
                                  positionSingle(http.Client(), deviceId, imei, command);
                                },
                                iconData: Icons.share,
                                namebutton: "",
                                color: Colors.red,
                                size: 25,
                                circular: 10,
                              ),
                              ButtonIconWidget(
                                function: (){
                                  setState(() {
                                    isVisible = !isVisible;
                                    isVisibleCard = !isVisibleCard;
                                  });
                                },
                                iconData: Icons.close,
                                namebutton: "",
                                color: Colors.red,
                                size: 25,
                                circular: 10,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.loose,
                                child: Container(
                                  padding: const EdgeInsets.only(top: 5, right: 0, left: 10, bottom: 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      const Icon(Icons.location_on_outlined, color: Colors.green),
                                      Expanded(child: Text(address ?? "Cargando...", style: const TextStyle(fontSize: 18), softWrap: false, overflow: TextOverflow.ellipsis, maxLines: 2)),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.loose,
                                child: Container(
                                  padding: const EdgeInsets.only(top: 5, right: 0, left: 15, bottom: 0),
                                  child: Row(
                                    children: <Widget>[
                                      const Icon(Icons.date_range_outlined, color: Colors.green),
                                      Expanded(
                                        child: Text("${time.day}/${time.month}/${time.year}   ${time.hour}:${time.minute}",
                                            style: const TextStyle(fontSize: 18), softWrap: false, overflow: TextOverflow.ellipsis, maxLines: 4),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                          Column(
                            children: [
                              ButtonIconWidget2(
                                function: (){
                                  _getCurrentLocation(http.Client());
                                  mapController.move(point, 16);
                                },
                                namebutton: "Solicitar ubicacion",
                                color: Colors.green,
                                circular: 15,
                                height: 55,
                                width: 190,
                                icon: const Icon(Icons.location_on),
                              ),
                              const SizedBox(height: 10),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05),
                                  child: Row(
                                    children: <Widget>[
                                      ButtonIconWidget2(
                                        function: ()async{
                                          setState(() {
                                            blockCar =! blockCar;
                                          });
                                          ToastContext().init(context);
                                          Toast.show("Preparando dispositivo para compartir ubicacion", gravity: Toast.bottom, duration: Toast.lengthLong);
                                          int deviceId = int.parse("343");
                                          String imei = await identificationDevice.getImei(http.Client(), widget.token, deviceId);
                                          String command = "engineStop";
                                          statusCommand = await connectService.commandSend(http.Client(), deviceId, imei, command);
                                          print(command);
                                          try{
                                            if (statusCommand == true) {
                                              ToastContext().init(context);
                                              Toast.show("OK, Listo.", gravity: Toast.bottom, duration: Toast.lengthLong);
                                              setState(() {
                                                blockDoor == true;
                                              });
                                              //print(statusCommand);
                                            } else if (statusCommand == false) {
                                              ToastContext().init(context);
                                              Toast.show("Dispositivo desconectado", gravity: Toast.bottom, duration: Toast.lengthLong);
                                              setState(() {
                                                blockDoor == false;
                                              });
                                              //print(statusCommand);
                                            }
                                          }catch(e){
                                            ToastContext().init(context);
                                            Toast.show(e.toString(), gravity: Toast.bottom, duration: Toast.lengthLong);
                                          }
                                        },
                                        namebutton: blockCar == false ? car[0] : car[1],
                                        color: blockCar == false ? Colors.green : Colors.red,
                                        circular: 10,
                                        height: 50,
                                        width: 95,
                                        icon: blockCar == false
                                            ? const Icon(Icons.lock, color: Colors.red)
                                            : const Icon(Icons.lock_open, color: Colors.white),
                                      ),
                                      const SizedBox(width: 10),
                                      ButtonIconWidget2(
                                        function: ()async{
                                          setState(() {
                                            blockDoor =! blockDoor;
                                          });
                                          ToastContext().init(context);
                                          Toast.show("Preparando dispositivo para compartir ubicacion", gravity: Toast.bottom, duration: Toast.lengthLong);
                                          int deviceId = int.parse("343");
                                          String imei = await identificationDevice.getImei(http.Client(), widget.token, deviceId);
                                          String commandDis = "alarmDisarm";
                                          String commandArm = "alarmArm";
                                          statusCommand = await connectService.commandSend(http.Client(), deviceId, imei, blockDoor == false ? commandArm : commandDis);
                                          print(blockDoor == false ? commandArm : commandDis);
                                          try{
                                            if (statusCommand == true) {
                                              ToastContext().init(context);
                                              Toast.show("OK, Listo.", gravity: Toast.bottom, duration: Toast.lengthLong);
                                              setState(() {
                                                blockDoor == true;
                                              });
                                              //print(statusCommand);
                                            } else if (statusCommand == false) {
                                              ToastContext().init(context);
                                              Toast.show("Dispositivo desconectado", gravity: Toast.bottom, duration: Toast.lengthLong);
                                              setState(() {
                                                blockDoor == false;
                                              });
                                              //print(statusCommand);
                                            }
                                          }catch(e){
                                            ToastContext().init(context);
                                            Toast.show(e.toString(), gravity: Toast.bottom, duration: Toast.lengthLong);
                                          }
                                        },
                                        namebutton: blockDoor == false ? door[0] : door[1],
                                        color: blockDoor == false ? Colors.green : Colors.red,
                                        circular: 10,
                                        height: 50,
                                        width: 95,
                                        icon: blockDoor == false
                                            ? const Icon(Icomoon.openDoorCar, color: Colors.red)
                                            : const Icon(Icomoon.openDoorCar, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const abstractData()));
                              },
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
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const reportData()));
                              },
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
                )
            ); //widget Card data users
          },
          child: Card(
            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
            elevation: 10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height* 0.01,
                  left: MediaQuery.of(context).size.width * 0.02,
                  right: MediaQuery.of(context).size.width * 0.02,
                  bottom: MediaQuery.of(context).size.height * 0.01
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Expanded(flex: 1, child: Icon(Icons.circle, color: Colors.green)),
                      Expanded(flex: 3, child: Text(data.toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const <Widget>[
                      Expanded(flex: 1, child: Icon(Icons.speed, color: Colors.green)),
                      Expanded(flex: 3, child: Text("10 km/h", style: TextStyle(fontSize: 16), softWrap: false, overflow: TextOverflow.ellipsis, maxLines: 4)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Expanded(flex: 1, child: Icon(Icons.location_on_outlined, color: Colors.green)),
                      Expanded(flex: 3, child: Text(address ?? "Cargando...", style: const TextStyle(fontSize: 16), softWrap: false, overflow: TextOverflow.ellipsis, maxLines: 5)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    return cardDevice;
  }

  //Location locationData;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getCurrentLocation(http.Client()),
        builder: (ctx, snapshot){
          if(snapshot.hasData){
            return mapFlutter(snapshot.data, _currentAddress, now, mapController, 340);
          }
          else if(snapshot.hasError){
            return Container();
          }
          return const Center(child: CircularProgressIndicator());
        }
    );
  }
}