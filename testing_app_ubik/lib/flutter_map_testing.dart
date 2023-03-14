import 'dart:convert';
import 'package:testing_app_ubik/src/api_commandSend.dart';
import 'package:testing_app_ubik/src/api_getImei.dart';
import 'package:testing_app_ubik/src/buttonDesignIcon2.dart';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:testing_app_ubik/src/api_getDeviceALl.dart';
import 'package:testing_app_ubik/src/api_setLocation.dart';
import 'package:testing_app_ubik/src/buttonDesignIcon.dart';
import 'package:testing_app_ubik/src/getAllDevice.dart';
import 'package:testing_app_ubik/src/getClassLocation.dart';

class MapFlutter extends StatefulWidget {
  const MapFlutter({Key key, @required this.token}) : super(key: key);

  final String token;

  @override
  State<MapFlutter> createState() => _MapFlutterState();
}

class _MapFlutterState extends State<MapFlutter> {
  MapController _mapController;
  Position _currentPosition;
  LatLng punto, pointer;
  String _currentAddress, deviceId;
  ApiDeviced deviced = ApiDeviced();
  ApiPosition position = ApiPosition();
  ApiUbik connectService = ApiUbik();
  ApiIdentificationDevice identificationDevice = ApiIdentificationDevice();
  bool isVisibleCard =  true;
  bool isVisible = false;
  bool blockCar = false;
  bool blockDoor = false;
  bool statusCommand;
  List<AllDevice> listDevicesAll; // list class device
  List<AllDevice> listDevices; // list class device
  List<String> deviceItemList =[]; //convert future to string for dropdownbutton

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    listDispositivos(deviced.getAllDevice(http.Client(), widget.token));
  }

  void listDispositivos(Future<List<AllDevice>> data)async{
    listDevicesAll = await data;
    for(int x=0; x<listDevicesAll.length; x++){
      deviceItemList.add(listDevicesAll[x].deviceId);
    }
  }

  flutterMap(List<String> device){
    Widget informationDevice;
    return informationDevice;
  }

  List<Widget> cardListWidget(List<LocationDevice> data, String address){
    List<Widget> informationDevice = [];
    for(var i in data){
      informationDevice.add(SizedBox(
        height: 200,
        width: 300,
        child: Card(
          elevation: 10,
          child: InkWell(
            child: Column(
              children: [
                Row(
                  children: [
                    i.status == "offline" ? const Icon(Icons.circle, color: Colors.red) : const Icon(Icons.circle, color: Colors.green),
                    Text("${i.deviceId}", style: const TextStyle(fontSize: 20)),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.date_range, color: Colors.green),
                    Text(i.serverTime, style: const TextStyle(fontSize: 20)),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.speed, color: Colors.green),
                    Text(i.speed.toString(), style: const TextStyle(fontSize: 20)),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.green),
                    Text(address ?? "Cargando", style: const TextStyle(fontSize: 20)),
                  ],
                ),
              ],
            ),
            onLongPress: (){
              showDialog(context: context, builder: (builder)=> AlertDialog(
                title: Text("${i.deviceId}", textAlign: TextAlign.center),
                content: StatefulBuilder(builder: (BuildContext context, StateSetter setState){
                  return SizedBox(
                    height: 300,
                    width: 350,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            const CircleAvatar(
                              radius: 20,
                              child: Icon(Icons.person, size: 40),
                            ),
                            const Icon(Icons.circle, color: Colors.green),
                            Column(
                              children: [
                                Text("${i.deviceId}", style: TextStyle(fontSize: 20)),
                                const SizedBox(height: 5),
                                Text(i.speed.toString()),
                              ],
                            ),
                            ButtonIconWidget(
                              function: ()async{
                                ToastContext().init(context);
                                Toast.show("Preparando dispositivo para compartir ubicacion", gravity: Toast.bottom, duration: Toast.lengthLong);
                                int deviceId = int.parse("${i.deviceId}");
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
                                    Expanded(child: Text(address ?? "Cargando", style: const TextStyle(fontSize: 18), softWrap: false, overflow: TextOverflow.ellipsis, maxLines: 2)),
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
                                      child: Text(i.serverTime,
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
                                _getCurrentLocation(http.Client(), "${i.deviceId}");
                                LatLng latLng = LatLng(i.latitude, i.longitude);
                                _mapController.move(latLng, 16);
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
                                        int deviceId = int.parse("${i.deviceId}");
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
                                      namebutton: blockCar == false ? "Abrir Puertas" : "Cerrar Puertas",
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
                                        int deviceId = int.parse("${i.deviceId}");
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
                                      namebutton: blockDoor == false ? "Cerrar puertas" : "Abrir Puertas",
                                      color: blockDoor == false ? Colors.green : Colors.red,
                                      circular: 10,
                                      height: 50,
                                      width: 95,
                                      icon: blockDoor == false
                                          ? const Icon(Icons.car_crash_sharp, color: Colors.red)
                                          : const Icon(Icons.car_crash_sharp, color: Colors.white),
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
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => const abstractData()));
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
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => const reportData()));
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
                  );
                }),
              ));
            },
          ),
        ),
      ));
    }
    return informationDevice;
  }
  List<Marker> _markersDevice (List<LocationDevice> data){
    List<Marker> markers = [];
    for(var i in data){
      markers.add(
          Marker(
            width: 40,
            height: 40,
            point: LatLng(i.latitude, i.longitude),
            builder: (ctx) => const Icon(
              Icons.location_on,
              color: Colors.red,
              size: 40,
            ),
          )
      );
    }
    return markers;
  }

  cardWidgetGeneral(List<LocationDevice> data){
    Widget informationDevice;
    for(var i in data){
      informationDevice =
          SizedBox(
            height: 250,
            width: 350,
            child: Card(
              elevation: 10,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
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
                      const Icon(Icons.visibility, color: Colors.green, size: 30),
                      const Icon(Icons.close, color: Colors.green, size: 30),
                    ],
                  )
                ],
              ),
            ),
          );
    }
  }

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
  }//Function general

  Future<LatLng> _getCurrentLocation(http.Client client, String device) async {
    int deviceId = int.parse(device);
    await Future.delayed(const Duration(seconds: 1));
    var url = "http://159.89.83.60:8082/position/$deviceId";
    final response = await client.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    print(jsonData);
    if(response.statusCode == 200){
      setState(() {
        punto = LatLng(jsonData['response'][0]['latitude'], jsonData['response'][0]['longitude']);
        _currentPosition = Position(longitude: punto.longitude, latitude: punto.latitude);
        _getAddressPosition(_currentPosition);
      });
    }
    return punto;
  }//Function initial device in flutter map


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.grey
      ),
      child: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: punto ?? LatLng(-2.150430, -79.893929),
              zoom: 16,
              maxZoom: 18.25,
              minZoom: 15,
            ),
            mapController: _mapController,
            children: [
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c'],
              ),
              FutureBuilder(
                  future: position.setCurrentLocationAll(http.Client(), widget.token),
                  builder: (ctx, snapshot){
                    if(snapshot.hasData){
                      return MarkerLayer(
                        markers: _markersDevice(snapshot.data),
                      );
                    }else if(snapshot.hasError){
                      return const CircularProgressIndicator();
                    }
                    return const CircularProgressIndicator();
                  }

              ),
            ],
          ),
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
                    child: FutureBuilder<List<LocationDevice>>(
                      future: position.setCurrentLocationAll(http.Client(), widget.token),
                      builder: (ctx, snapshot){
                        if(snapshot.hasData){
                          return Row(
                            children: cardListWidget(snapshot.data, _currentAddress),
                          );
                        }else if (snapshot.hasError){
                          return Center(child: Text(snapshot.error.toString()));
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
}
