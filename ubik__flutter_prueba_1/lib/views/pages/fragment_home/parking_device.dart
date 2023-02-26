// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_ubik.dart';
import 'package:ubik_gps_application_flutter/views/pages/fragment_home/fragment_map/map_open_street_map.dart';

class ParkingDevice extends StatefulWidget{
  const ParkingDevice({Key key}) : super(key: key);

  @override
  _ParkingDeviceState createState()=> _ParkingDeviceState();
}

class _ParkingDeviceState extends State<ParkingDevice>{
  String deviceParking;
  List deviceItemParking = ["343"];
  ApiUbik connect = ApiUbik();
  bool statusCommand;

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color(0xff170101),
              Color(0xFF360505),
              Color(0xFF490C0C),
              Color(0xff980d0d),
              Color(0xffbb0404),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("PARQUEO"),
          titleTextStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 80, top: 45),
                child: const Image(image: AssetImage('images/logo_ubik_gps.png'), height: 125),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      right: 15,
                      left: 15,
                      top: MediaQuery.of(context).size.height * 0.22
                  ),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, right: 15, left: 15, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: DropdownButton(
                              hint: const Text("Selected device: "),
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 35,
                              underline: Container(),
                              isExpanded: true,
                              value: deviceParking,
                              style: const TextStyle(fontSize: 20, color: Colors.grey),
                              onChanged: (value){
                                setState((){
                                  deviceParking = value;
                                });
                              },
                              items: deviceItemParking.map((valueItem){
                                return DropdownMenuItem(
                                    value: valueItem,
                                    child: Text(valueItem)
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.only(right: 15, left: 15),
                            child: const Text("Pon limites a tu carro, hasta donde puede andar libremente", softWrap: true, textAlign: TextAlign.justify,
                                style: TextStyle(color: Colors.grey, fontSize: 20)),
                          ),
                          const SizedBox(height: 15),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: (){
                                    String command_type = "engineStop";
                                    String deviceSelect = deviceParking;
                                    int device = int.parse(deviceSelect);

                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      primary: Colors.green, elevation: 5),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                                    child: const Text('Activar', softWrap: true,
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () async{
                                    String command_type = "engineStop";
                                    String deviceSelect = deviceParking;
                                    int device = int.parse(deviceSelect);
                                    //statusCommand = await connect.commandSend(command_type, device);
                                    if(statusCommand == true){
                                      Toast.show("Comando enviado exitosamente", duration: Toast.lengthShort, gravity: Toast.bottom);
                                    }else if(statusCommand == false){
                                      Toast.show("Error en el comando", duration: Toast.lengthShort, gravity: Toast.bottom);
                                    }
                                    setState((){});
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      primary: Colors.red, elevation: 5),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                                    child: const Text('Desactivar', softWrap: true,
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                  ),
                                )
                              ]),
                          const SizedBox(height: 10),
                          const Divider(color: Colors.black),
                          const SizedBox(height: 25),
                          const Text("CERCA VIRTUAL", softWrap: true, textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 30)),
                          const SizedBox(height: 15),
                          Container(
                            padding: const EdgeInsets.only(right: 15, left: 15),
                            child: const Text("Pon limites a tu carro, hasta donde puede andar libremente", softWrap: true, textAlign: TextAlign.justify,
                                style: TextStyle(color: Colors.grey, fontSize: 20)),
                          ),
                          const SizedBox(height: 25),
                          ElevatedButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> const MapOpenStreet()));
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                primary: Colors.green),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                              child: const Text('Ir al mapa',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ),
              ),
            ]
        ),
      ),
    );
  }
}