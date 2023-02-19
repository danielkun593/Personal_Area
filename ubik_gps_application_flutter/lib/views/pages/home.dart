// ignore_for_file: public_member_api_docs, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, use_build_context_synchronously
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:toast/toast.dart';
import 'package:ubik_gps_application_flutter/components/buttonDesign.dart';
import 'package:ubik_gps_application_flutter/components/circularButton.dart';
import 'package:ubik_gps_application_flutter/components/decorationBackground.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_assesorlist.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_caller.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_device.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_identificationdevice.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_login.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_ubik.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_whatsapplink.dart';
import 'package:ubik_gps_application_flutter/src/models/getAsessor.dart';
import 'package:ubik_gps_application_flutter/src/models/getDeviceImei.dart';
import 'package:ubik_gps_application_flutter/src/models/getDeviceUser.dart';
import 'package:ubik_gps_application_flutter/src/models/sharedPreferencesClass.dart';
import 'package:ubik_gps_application_flutter/src/models/userData.dart';
import 'package:ubik_gps_application_flutter/views/pages/fragment_home/fragment_map/map_open_street_map.dart';
import 'package:ubik_gps_application_flutter/views/pages/fragment_home/fragment_alert/alerts.dart';
import 'package:ubik_gps_application_flutter/views/pages/fragment_home/renew_plan.dart';
import 'package:ubik_gps_application_flutter/views/pages/fragment_home/report_data.dart';
import 'package:ubik_gps_application_flutter/views/pages/fragment_home/smartcare.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name = '';
  ApiUbik connectService = ApiUbik();
  ApiIdentificationDevice identificationDevice = ApiIdentificationDevice();
  ApiDeviced deviceid = ApiDeviced(); ApiLogin userdata = ApiLogin();
  ApiCall caller = ApiCall();
  ApiAssesor assesor = ApiAssesor();
  ApiWhatsapp whatsapp = ApiWhatsapp();
  UserPreferences userPreferences = UserPreferences();
  Future<List<Usuario>> listData;
  bool commandSend = false;
  LatLng punto;
  String _currentAddress;
  Position _currentPosition;
  int cantAlert = 10;

  //Variables Convert Future<list> to List
  //List Device
  Future<List<AllDevice>> listDevice;
  List<AllDevice> listDevicesAll;
  List<String> deviceItemList =[];
  //Imei device
  Future<List<DeviceImei>> listDeviceImei;
  List<DeviceImei> listImei;
  String deviceImeiList;

  //
  List<String> typeAsesoria = ["Asistencia medica", "Servicio de Grua", "Asistencia mecanica"];
  Future<List<Assesor>> listAsessor;

  infoAsesor (List<Assesor> data){
    Widget cardInformation;
    for(var i in data){
      cardInformation =
          SizedBox(
            height: 150,
            width: 300,
            child: Column(
              children: [
                Text("Asistente Sr/a. ${i.name}", softWrap: true, style: const TextStyle(fontSize: 22, color: Colors.grey)),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(height: 25),
                    Expanded(
                      flex: 1,
                      child: CircularButton(
                        function: (){
                          whatsapp.connectWhatsApp('+593${i.phone}', "");
                        },
                        color: Colors.red,
                        iconData: Icons.whatshot,
                        nameButton: "WhatsApp",
                        size: 50,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: CircularButton(
                        function: (){
                          caller.connectCall('0${i.phone}');
                        },
                        color: Colors.red,
                        iconData: Icons.phone,
                        nameButton: "Llamar",
                        size: 50,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
    }
    return cardInformation;
  }
  infoCarga(){
    Widget cardCarga;
    cardCarga =
    const SizedBox(
      height: 150,
      width: 300,
      child: Center(child: CircularProgressIndicator()),
    );
    return cardCarga;
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

  //Function Convert Future<list> to List
  //Get List Device
  void listDispositivos(Future<List<AllDevice>> data)async{
    listDevicesAll = await data;
    for(int x=0; x<listDevicesAll.length; x++){
      deviceItemList.add(listDevicesAll[x].deviceId);
    }
  }
  //Get Imei
  ImeiDevice(Future<List<DeviceImei>> data)async{
    listImei = await data;
    deviceImeiList = listImei[0].deviceImei;
    return deviceImeiList;
  }

  bool statusCommand;
  String deviceListen, deviceOpen, deviceParking;

  @override
  void initState(){
    super.initState();
    listData = userdata.dataUserHome();
    listDevice = deviceid.getAllDevice();
    listDispositivos(listDevice);
    _getCurrentLocation();
  }

  dataUser(List<Usuario> data) {
    Widget mensaje;
    for (var x in data) {
      mensaje = Text("Bienvenido ${x.name}, \ntiene ${x.notifications} notificaciones pendientes",
          softWrap: true, textAlign: TextAlign.justify, style: const TextStyle(fontSize: 20));
    }
    return mensaje;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: DecorationBack.backgroundGradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 30),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: Expanded(
                          flex: 1,
                          child: FutureBuilder(
                              future: listData,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return dataUser(snapshot.data);
                                } else if (snapshot.hasError) {
                                  return Container();
                                }
                                return const Center(child: CircularProgressIndicator());
                              }),
                        ),
                      ),
                    ),
                  ),
                )),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Stack(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            elevation: 10,
                            color: const Color.fromRGBO(37, 68, 91, 100),
                            child: InkWell(
                              child: Container(
                                width: MediaQuery.of(context).size.width*0.5,
                                padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Image.asset(
                                        'images/alert.png',
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Expanded(
                                        flex: 1,
                                        child: Text('ALERTAS',
                                            style: TextStyle(fontSize: 18, color: Colors.white), textAlign: TextAlign.center, softWrap: true)),
                                  ],
                                ),
                              ),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const Alerts()));
                              },
                            ),
                          ),
                          Positioned(
                              top: 0,
                              left: MediaQuery.of(context).size.width*0.245,
                              child: Container(
                                alignment: Alignment.center,
                                height: 25,
                                width: 25,
                                decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle
                                ),
                                child: Text(cantAlert.toString(), style:const TextStyle(color: Colors.white, fontSize: 18)),
                              )
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 10,
                        color: const Color.fromRGBO(37, 68, 91, 100),
                        child: InkWell(
                          child: Container(
                            padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Image.asset(
                                    'images/smart_care.png',
                                    //height: 150, width: 140,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const SmartCare()));
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 10,
                        color: const Color.fromRGBO(37, 68, 91, 100),
                        child: InkWell(
                          child: Container(
                            padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Image.asset(
                                    'images/mic.png',
                                    color: Colors.white,
                                  ),
                                ),
                                const Expanded(
                                    flex: 1,
                                    child: Text('ESCUCHAR',
                                        style: TextStyle(fontSize: 18, color: Colors.white), textAlign: TextAlign.center, softWrap: true)),
                              ],
                            ),
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                    title: const Text("ESCUCHAR DISPOSITIVO",
                                        textAlign: TextAlign.center, style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
                                    content: StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                                      return SizedBox(
                                        height: 150,
                                        width: 450,
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 10, right: 5, left: 5, bottom: 1),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.grey, width: 1),
                                                    borderRadius: BorderRadius.circular(5)),
                                                child: DropdownButton(
                                                  hint: const Text("Seleccione vehiculo"),
                                                  icon: const Icon(Icons.arrow_drop_down),
                                                  iconSize: 35,
                                                  isExpanded: true,
                                                  underline: Container(),
                                                  value: deviceListen,
                                                  style: const TextStyle(fontSize: 20, color: Colors.grey),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      deviceListen = value;
                                                    });
                                                  },
                                                  alignment: AlignmentDirectional.centerStart,
                                                  items: deviceItemList.map((valueItem) {
                                                    return DropdownMenuItem(value: valueItem, child: Text(valueItem));
                                                  }).toList(),
                                                ),
                                              ),
                                              const SizedBox(height: 15),
                                              Container(
                                                padding: const EdgeInsets.only(right: 15, left: 15),
                                                child: const Text("Pon limites a tu carro, hasta donde puede andar libremente",
                                                    softWrap: true,
                                                    textAlign: TextAlign.justify,
                                                    style: TextStyle(color: Colors.grey, fontSize: 20)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                    actions: [
                                      ButtonBar(
                                        alignment: MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            fit: FlexFit.tight,
                                            child: ButtonWidget(
                                              function: (){},
                                              namebutton: "Activar",
                                              height: 15,
                                              width: 30,
                                              circular: 10,
                                              color: Colors.green,
                                            ),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            fit: FlexFit.tight,
                                            child: ButtonWidget(
                                              function: (){},
                                              namebutton: "Desactivar",
                                              height: 15,
                                              width: 15,
                                              circular: 10,
                                              color: Colors.red,
                                            ),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            fit: FlexFit.tight,
                                            child: ButtonWidget(
                                              function: (){},
                                              namebutton: "Grabar",
                                              height: 15,
                                              width: 30,
                                              circular: 10,
                                              color: Colors.orange,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: MediaQuery.of(context).size.height*0.02),
                                    ],
                                  );
                                });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 10,
                        color: const Color.fromRGBO(37, 68, 91, 100),
                        child: InkWell(
                          child: Container(
                            padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Image.asset(
                                    'images/share_ubications.png',
                                    color: Colors.white,
                                  ),
                                ),
                                const Expanded(
                                    flex: 1,
                                    child: Text('COMPARTIR UBICACION',
                                        style: TextStyle(fontSize: 18, color: Colors.white), textAlign: TextAlign.center, softWrap: true)),
                              ],
                            ),
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                      title: const Text("COMPARTIR UBICACION",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
                                      content: SizedBox(
                                        height: 180,
                                        width: 375,
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 15),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: CircularButton(
                                                    function: (){
                                                      whatsapp.connectWhatsApp("+593991441603", "Ultima ubicacion del dispositivo: $_currentAddress");
                                                    },
                                                    iconData: Icons.whatshot,
                                                    color: Colors.red,
                                                    nameButton: "WhatsApp",
                                                    size: 50,
                                                  ),
                                                ),
                                                const Expanded(
                                                  flex: 1,
                                                  child: CircularButton(
                                                    function: null,
                                                    iconData: Icons.telegram,
                                                    color: Colors.red,
                                                    nameButton: "Telegram",
                                                    size: 50,
                                                  ),
                                                ),
                                                const Expanded(
                                                  flex: 1,
                                                  child: CircularButton(
                                                    function: null,
                                                    iconData: Icons.sms,
                                                    color: Colors.red,
                                                    nameButton: "SMS",
                                                    size: 50,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 15),
                                            const Text("Dependiendo de la emergencia elige el servicio que sea mas conveniente",
                                                softWrap: true, style: TextStyle(color: Colors.grey))
                                          ],
                                        ),
                                      ),
                                    ));
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 10,
                        color: const Color.fromRGBO(37, 68, 91, 100),
                        child: InkWell(
                          child: Container(
                            padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Image.asset(
                                    'images/renovar_plan.png',
                                    //height: 150, width: 140,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const RenewPlan()));
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 10,
                        color: const Color.fromRGBO(37, 68, 91, 100),
                        child: InkWell(
                          child: Container(
                            padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Image.asset(
                                    'images/reports_ubik.png',
                                    //height: 125, width: 140,
                                  ),
                                ),
                                const Expanded(
                                    flex: 1,
                                    child: Text(
                                      'REPORTES',
                                      style: TextStyle(fontSize: 18, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    )),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportsData()));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 10,
                        color: const Color.fromRGBO(37, 68, 91, 100),
                        child: InkWell(
                          child: Container(
                            padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Image.asset(
                                    'images/parking.png',
                                    color: Colors.white,
                                  ),
                                ),
                                const Expanded(
                                    flex: 1,
                                    child: Text('PARQUEO DE VEHICULO',
                                        style: TextStyle(fontSize: 18, color: Colors.white), textAlign: TextAlign.center, softWrap: true)),
                              ],
                            ),
                          ),
                          onTap: () {
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => const ParkingDevice()));
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                    title: const Text("PARQUEO DE VEHICULOS",
                                        textAlign: TextAlign.center, style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
                                    content: StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                                      return SizedBox(
                                        height: 425,
                                        width: 450,
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 20, right: 5, left: 5, bottom: 20),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.grey, width: 1),
                                                    borderRadius: BorderRadius.circular(5)),
                                                child: DropdownButton(
                                                  hint: const Text("Selected device: "),
                                                  icon: const Icon(Icons.arrow_drop_down),
                                                  iconSize: 35,
                                                  underline: Container(),
                                                  isExpanded: true,
                                                  value: deviceParking,
                                                  style: const TextStyle(fontSize: 20, color: Colors.grey),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      deviceParking = value;
                                                    });
                                                  },
                                                  items: deviceItemList.map((valueItem) {
                                                    return DropdownMenuItem(value: valueItem, child: Text(valueItem));
                                                  }).toList(),
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              Container(
                                                padding: const EdgeInsets.only(right: 15, left: 15),
                                                child: const Text("Pon limites a tu carro, hasta donde puede andar libremente",
                                                    softWrap: true,
                                                    textAlign: TextAlign.justify,
                                                    style: TextStyle(color: Colors.grey, fontSize: 20)),
                                              ),
                                              const SizedBox(height: 15),
                                              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                                ElevatedButton(
                                                  onPressed: () {},
                                                  style: ElevatedButton.styleFrom(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(20),
                                                      ),
                                                      backgroundColor: Colors.green,
                                                      elevation: 5),
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                                                    child: const Text(
                                                      'Activar',
                                                      softWrap: true,
                                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () async{
                                                    String command = "engineStop";
                                                    var deviceId = int.parse(deviceParking);
                                                    listDeviceImei = identificationDevice.getImei(deviceId);
                                                    var imei = ImeiDevice(listDeviceImei);
                                                    commandSend = await connectService.commandSend(command, deviceId, imei);
                                                    if(commandSend == true){
                                                      Toast.show("Comando enviado exitosamente", duration: Toast.lengthShort, gravity: Toast.bottom);
                                                    }else{
                                                      Toast.show("Error en el envio de comandos", duration: Toast.lengthShort, gravity: Toast.bottom);
                                                    }
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(20),
                                                      ),
                                                      backgroundColor: Colors.red,
                                                      elevation: 5),
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                                                    child: const Text(
                                                      'Desactivar',
                                                      softWrap: true,
                                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                                    ),
                                                  ),
                                                )
                                              ]),
                                              const SizedBox(height: 25),
                                              const Text("CERCA VIRTUAL",
                                                  softWrap: true,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 30)),
                                              const SizedBox(height: 15),
                                              Container(
                                                padding: const EdgeInsets.only(right: 15, left: 15),
                                                child: const Text("Pon limites a tu carro, hasta donde puede andar libremente",
                                                    softWrap: true,
                                                    textAlign: TextAlign.justify,
                                                    style: TextStyle(color: Colors.grey, fontSize: 20)),
                                              ),
                                              const SizedBox(height: 25),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MapOpenStreet()));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                    backgroundColor: Colors.green),
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                                                  child: const Text(
                                                    'Ir al mapa',
                                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  );
                                });
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 10,
                        color: const Color.fromRGBO(37, 68, 91, 100),
                        child: InkWell(
                          child: Container(
                            padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Image.asset(
                                    'images/sos_ubik.png',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text("EMERGENCIA SOS",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 30)),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                      content: Container(
                                        height: 450,
                                        width: 300,
                                        padding: const EdgeInsets.only(top: 15, bottom: 15, right: 5, left: 5),
                                        child: Column(children: [
                                          const Text("Dependiendo la emergencia elige el servicio que mas sea conveniente. ",
                                              softWrap: true,
                                              style: TextStyle(fontSize: 20, color: Colors.grey),
                                              textAlign: TextAlign.justify),
                                          const SizedBox(height: 15),
                                          Row(
                                            children: [
                                              Flexible(
                                                  flex: 1,
                                                  fit: FlexFit.tight,
                                                  child: Image.asset('images/police.png', height: 75, width: 25, color: Colors.grey)),
                                              Flexible(
                                                  flex: 2,
                                                  fit: FlexFit.tight,
                                                  child: Column(children: [
                                                    const SizedBox(height: 10),
                                                    ButtonWidget(
                                                      function: (){
                                                        caller.connectCall('911');
                                                      },
                                                      namebutton: "Policia Nacional",
                                                      height: 15,
                                                      width: 25,
                                                      circular: 10,
                                                      color: Colors.blue,
                                                    ),
                                                  ])),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Flexible(
                                                  flex: 1,
                                                  fit: FlexFit.tight,
                                                  child: Image.asset(
                                                    'images/service_grua.png',
                                                    height: 75,
                                                    width: 25,
                                                    color: Colors.grey,
                                                  )),
                                              Flexible(
                                                  flex: 2,
                                                  fit: FlexFit.tight,
                                                  child: Column(children: [
                                                    const SizedBox(height: 10),
                                                    ButtonWidget(
                                                      function: (){
                                                        setState((){
                                                          listAsessor = assesor.asesorUser(typeAsesoria[1]);
                                                          showDialog(
                                                              context: context,
                                                              builder: (context) => AlertDialog(
                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                                title: const Text("SERVICIO DE GRUA",
                                                                    textAlign: TextAlign.center,
                                                                    style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
                                                                content: FutureBuilder(
                                                                    future: listAsessor,
                                                                    builder: (ctx, snapshot){
                                                                      if(snapshot.hasData){
                                                                        return infoAsesor(snapshot.data);
                                                                      }
                                                                      else if(snapshot.hasError){
                                                                        return infoCarga();
                                                                      }
                                                                      return infoCarga();
                                                                    }
                                                                ),
                                                              ));
                                                        });
                                                      },
                                                      namebutton: "Servicio de Grua",
                                                      height: 15,
                                                      width: 25,
                                                      circular: 10,
                                                      color: Colors.blueGrey,
                                                    ),
                                                  ])),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Flexible(
                                                  flex: 1,
                                                  fit: FlexFit.tight,
                                                  child: Image.asset(
                                                    'images/medico.png',
                                                    height: 75,
                                                    width: 25,
                                                    color: Colors.grey,
                                                  )),
                                              Flexible(
                                                  flex: 2,
                                                  fit: FlexFit.tight,
                                                  child: Column(children: [
                                                    const SizedBox(height: 10),
                                                    ButtonWidget(
                                                      function: (){
                                                        setState((){
                                                          listAsessor = assesor.asesorUser(typeAsesoria[0]);
                                                          showDialog(
                                                              context: context,
                                                              builder: (context) => AlertDialog(
                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                                title: const Text("ASISTENCIA MEDICA",
                                                                    textAlign: TextAlign.center,
                                                                    style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
                                                                content: FutureBuilder(
                                                                    future: listAsessor,
                                                                    builder: (ctx, snapshot){
                                                                      if(snapshot.hasData){
                                                                        return infoAsesor(snapshot.data);
                                                                      }
                                                                      else if(snapshot.hasError){
                                                                        return infoCarga();
                                                                      }
                                                                      return infoCarga();
                                                                    }
                                                                ),
                                                              ));
                                                        });
                                                      },
                                                      namebutton: "Asistencia Medica",
                                                      height: 15,
                                                      width: 15,
                                                      circular: 10,
                                                      color: Colors.blue,
                                                    ),
                                                  ])),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Flexible(
                                                  flex: 1,
                                                  fit: FlexFit.tight,
                                                  child: Image.asset('images/asist_carro.png', height: 75, width: 25, color: Colors.grey)),
                                              Flexible(
                                                  flex: 2,
                                                  fit: FlexFit.tight,
                                                  child: Column(children: [
                                                    const SizedBox(height: 10),
                                                    ButtonWidget(
                                                      function: (){
                                                        setState((){
                                                          listAsessor = assesor.asesorUser(typeAsesoria[2]);
                                                          showDialog(
                                                              context: context,
                                                              builder: (context) => AlertDialog(
                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                                title: const Text("ASISTENCIA MECANICA",
                                                                    textAlign: TextAlign.center,
                                                                    style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
                                                                content: FutureBuilder(
                                                                    future: listAsessor,
                                                                    builder: (ctx, snapshot){
                                                                      if(snapshot.hasData){
                                                                        return infoAsesor(snapshot.data);
                                                                      }
                                                                      else if(snapshot.hasError){
                                                                        return infoCarga();
                                                                      }
                                                                      return infoCarga();
                                                                    }
                                                                ),
                                                              ));
                                                        });
                                                      },
                                                      namebutton: "Asistencia Mecanica",
                                                      height: 15,
                                                      width: 10,
                                                      circular: 10,
                                                      color: Colors.blueGrey,
                                                    ),
                                                  ])),
                                            ],
                                          ),
                                        ]),
                                      ),
                                      elevation: 10,
                                    ));
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 10,
                        color: const Color.fromRGBO(37, 68, 91, 100),
                        child: InkWell(
                          child: Container(
                            padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Image.asset(
                                    'images/opened_car.png',
                                    color: Colors.white,
                                  ),
                                ),
                                const Expanded(
                                    flex: 1,
                                    child: Text('APERTURA DE PUERTAS',
                                        style: TextStyle(fontSize: 18, color: Colors.white), textAlign: TextAlign.center, softWrap: true)),
                              ],
                            ),
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                    title: const Text("APERTURA DE PUERTAS",
                                        textAlign: TextAlign.center, style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
                                    content: StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                                      return SizedBox(
                                        height: 250,
                                        width: 450,
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 20, right: 15, left: 15, bottom: 20),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.grey, width: 1),
                                                    borderRadius: BorderRadius.circular(5)),
                                                child: DropdownButton(
                                                  hint: const Text("Seleccione el dispositivo"),
                                                  icon: const Icon(Icons.arrow_drop_down),
                                                  iconSize: 35,
                                                  isExpanded: true,
                                                  value: deviceOpen,
                                                  underline: Container(),
                                                  style: const TextStyle(fontSize: 20, color: Colors.grey),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      deviceOpen = value;
                                                    });
                                                  },
                                                  items: deviceItemList.map((valueItem) {
                                                    return DropdownMenuItem(value: valueItem, child: Text(valueItem));
                                                  }).toList(),
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              Container(
                                                padding: const EdgeInsets.only(right: 15, left: 15),
                                                child: const Text("Pon limites a tu carro, hasta donde puede andar libremente",
                                                    softWrap: true,
                                                    textAlign: TextAlign.justify,
                                                    style: TextStyle(color: Colors.grey, fontSize: 20)),
                                              ),
                                              const SizedBox(height: 15),
                                              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(20),
                                                      ),
                                                      backgroundColor: Colors.green,
                                                      elevation: 5),
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                                                    child: const Text(
                                                      'Abrir',
                                                      softWrap: true,
                                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {},
                                                  style: ElevatedButton.styleFrom(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(20),
                                                      ),
                                                      backgroundColor: Colors.red,
                                                      elevation: 5),
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                                                    child: const Text(
                                                      'Cerrar',
                                                      softWrap: true,
                                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                              const SizedBox(height: 20),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  );
                                });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 120)
          ],
        ),
      ),
    );
  }
}