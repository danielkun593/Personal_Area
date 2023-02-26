// ignore_for_file: non_constant_identifier_names
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_caller.dart';
import 'package:ubik_gps_application_flutter/src/models/sharedPreferencesClass.dart';
import 'package:ubik_gps_application_flutter/views/pages/fragment_home/add_background.dart';
class Settings extends StatefulWidget {
  const Settings({Key key}) : super(key: key);

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  ApiCall caller = ApiCall();
  String name = '';
  UserPreferences userPreferences = UserPreferences();
  String deviceMap;
  List deviceItemMap = ["Device1", "Device2", "Device3", "Device4", "Device5"];
  bool swithch = false;
  bool swithchn1 = false;
  bool swithchn2 = false;
  bool swithchn3 = false;
  bool swithchn4 = false;
  bool swithchn5 = false;
  bool swithchn6 = false;
  bool swithchn7 = false;
  bool swithchn8 = false;
  bool swithchn9 = false;
  bool swithch1 = false;
  bool chech1= false;
  bool chech2= false;
  bool chech3= false;
  int contadorKm = 30;
  var numberLamina = "0991331603";

  Future<void> mostrarDatos() async {
    final userName = await userPreferences.getName();
    setState(() => name = userName);
  }

  @override
  void initState() {
    mostrarDatos();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
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
        body: SingleChildScrollView(
          child: Container(
              width: 500,
              padding: const EdgeInsets.only(
                  right: 20,
                  left: 20,
                  top: 120
              ),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      Text("MI CUENTA $name",
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 25)),
                      const SizedBox(height: 10),
                      const Divider(color: Colors.black),
                      //PREFERENCIAS
                      Container(
                        padding: const EdgeInsets.only(right: 225),
                        child: const Text('PREFERENCIAS', style: TextStyle(color: Colors.blueGrey,
                            fontWeight: FontWeight.bold, fontSize: 22)),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.dark_mode, size: 30),
                            const Text('Modo Oscuro', softWrap: true, style: TextStyle(fontSize: 20)),
                            Switch.adaptive(
                              value: swithch, activeColor: Colors.greenAccent,
                              onChanged: (bool value){
                                setState((){
                                  swithch = value;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.assignment, size: 30),
                            const Text('Diálogo', softWrap: true, style: TextStyle(fontSize: 20)),
                            Switch.adaptive(
                              value: swithch1, activeColor: Colors.greenAccent,
                              onChanged: (bool value){
                                setState((){
                                  swithch1 = value;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            const Icon(Icons.add_alert_sharp, size: 30),
                            const Text('Alertas predeterminadas', softWrap: true, style: TextStyle(fontSize: 20)),
                            ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                        scrollable: true,
                                        title: const Text(
                                            "NOTIFICACIONES Y ALERTAS",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
                                        content: SizedBox(
                                          height: 800,
                                          width: 500,
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(left: 25, right: 25),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text('Encendido / Apagado', softWrap: true, style: TextStyle(fontSize: 15)),
                                                    Switch.adaptive(
                                                      value: swithchn1, activeColor: Colors.greenAccent,
                                                      onChanged: (bool value){
                                                        setState((){
                                                          swithchn1 = value;
                                                        });
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(left: 25, right: 25),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text('Abrir P. / Cerrar P.', softWrap: true, style: TextStyle(fontSize: 15)),
                                                    Switch.adaptive(
                                                      value: swithchn2, activeColor: Colors.greenAccent,
                                                      onChanged: (bool value){
                                                        setState((){
                                                          swithchn2 = value;
                                                        });
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(left: 25, right: 25),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text('Desconección de batería', softWrap: true, style: TextStyle(fontSize: 15)),
                                                    Switch.adaptive(
                                                      value: swithchn3, activeColor: Colors.greenAccent,
                                                      onChanged: (bool value){
                                                        setState((){
                                                          swithchn3 = value;
                                                        });
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(left: 25, right: 25),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text('Niveles de gasolina', softWrap: true, style: TextStyle(fontSize: 15)),
                                                    Switch.adaptive(
                                                      value: swithchn4, activeColor: Colors.greenAccent,
                                                      onChanged: (bool value){
                                                        setState((){
                                                          swithchn4 = value;
                                                        });
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(left: 25, right: 25),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text('Golpes', softWrap: true, style: TextStyle(fontSize: 15)),
                                                    Switch.adaptive(
                                                      value: swithchn5, activeColor: Colors.greenAccent,
                                                      onChanged: (bool value){
                                                        setState((){
                                                          swithchn5 = value;
                                                        });
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(left: 25, right: 25),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text('Frenados bruscos', softWrap: true, style: TextStyle(fontSize: 15)),
                                                    Switch.adaptive(
                                                      value: swithchn6, activeColor: Colors.greenAccent,
                                                      onChanged: (bool value){
                                                        setState((){
                                                          swithchn6 = value;
                                                        });
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(left: 25, right: 25),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text('Aceleración brusca', softWrap: true, style: TextStyle(fontSize: 15)),
                                                    Switch.adaptive(
                                                      value: swithchn7, activeColor: Colors.greenAccent,
                                                      onChanged: (bool value){
                                                        setState((){
                                                          swithchn7 = value;
                                                        });
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(left: 25, right: 25),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text('Conductor ebrio', softWrap: true, style: TextStyle(fontSize: 15)),
                                                    Switch.adaptive(
                                                      value: swithchn8, activeColor: Colors.greenAccent,
                                                      onChanged: (bool value){
                                                        setState((){
                                                          swithchn8 = value;
                                                        });
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(left: 25, right: 25),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text('Exceso de velocidad', softWrap: true, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                                                    Switch.adaptive(
                                                      value: swithchn9, activeColor: Colors.greenAccent,
                                                      onChanged: (bool value){
                                                        setState((){
                                                          swithchn9 = value;
                                                        });
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                "$contadorKm Km", textAlign: TextAlign.center, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black54 ),
                                              ),
                                              const SizedBox(height: 10),
                                              SliderTheme(
                                                data: SliderTheme.of(context).copyWith(
                                                    thumbColor: Colors.greenAccent,
                                                    thumbShape:
                                                    const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                                                    overlayShape:
                                                    const RoundSliderOverlayShape(overlayRadius: 10.0)),
                                                child: Slider(
                                                  value: contadorKm.toDouble(),
                                                  /// maximum and minimum values
                                                  min: 000.0,
                                                  max: 250.0,
                                                  activeColor: Colors.greenAccent,
                                                  inactiveColor: Colors.green,
                                                  onChanged: (double newvalue) {
                                                    setState(() {
                                                      contadorKm = newvalue.round();
                                                    });
                                                  },
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              const Text( 'DISPOSITIVO POR DEFECTO', softWrap: true, textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                                              ),
                                              const SizedBox(height: 15),
                                              Container(
                                                padding: const EdgeInsets.only(right: 25, left: 25),
                                                child: const Text("Elige el dispositivo a mostrar en el mapa, la próxima vez que inicies sesión.", softWrap: true, textAlign: TextAlign.justify,
                                                  style: TextStyle(fontSize: 15, color: Colors.grey),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Container(
                                                padding: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.grey, width: 1),
                                                    borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: DropdownButton(
                                                  hint: const Text("Seleccionar un dispositivo: "),
                                                  icon: const Icon(Icons.arrow_drop_down),
                                                  iconSize: 35,
                                                  isExpanded: true,
                                                  value: deviceMap,
                                                  style: const TextStyle(fontSize: 20, color: Colors.grey),
                                                  onChanged: (value){
                                                    setState((){
                                                      deviceMap = value;
                                                    });
                                                  },
                                                  items: deviceItemMap.map((valueItem){
                                                    return DropdownMenuItem(
                                                        value: valueItem,
                                                        child: Text(valueItem)
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  ElevatedButton(
                                                      onPressed: () {Navigator.pop(context, exitCode);},
                                                      style: ElevatedButton.styleFrom(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(10),
                                                          ), backgroundColor: Colors.redAccent),
                                                      child: Container(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 20, vertical: 15),
                                                        child: const Text(
                                                          'Aceptar',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.white),
                                                        ),
                                                      )),
                                                  const SizedBox(width: 10),
                                                  ElevatedButton(
                                                      onPressed: () {},
                                                      style: ElevatedButton.styleFrom(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(10),
                                                          ), backgroundColor: Colors.green),
                                                      child: Container(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 20, vertical: 15),
                                                        child: const Text(
                                                          'Guardar',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.white),
                                                        ),
                                                      )),
                                                ],

                                              )

                                            ],
                                          ),
                                        ),
                                      ));
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ), backgroundColor: Colors.blueGrey),
                                child: const Icon(Icons.arrow_forward_ios_rounded,
                                  size: 20,
                                ))
                          ],

                        ),
                      ),
                      const SizedBox(height: 10),
                      //CUENTA Y AYUDA
                      Container(
                        padding: const EdgeInsets.only(right: 225),
                        child: const Text('CUENTA Y AYUDA', style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 22)),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            const Icon(Icons.wallet_travel, size: 30),
                            const Text('Poductos y servicios', softWrap: true, style: TextStyle(fontSize: 20)),
                            ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                        title: const Text(
                                            "SERVICIOS Y PRODUCTOS",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
                                        content: SizedBox(
                                          height: 290,
                                          width: 500,
                                          child: Column(
                                            children: [
                                              Row(
                                                children:[
                                                  const SizedBox(width: 20),
                                                  const Icon(Icons.book_outlined, size: 30),
                                                  const SizedBox(width: 20),
                                                  const Text('Láminas de seguridad\n+593 0991331603',softWrap: true,
                                                      style: TextStyle(fontSize: 20), maxLines: 2,
                                                    textAlign: TextAlign.center,
                                                    textHeightBehavior: TextHeightBehavior(
                                                      applyHeightToFirstAscent: true,
                                                      applyHeightToLastDescent: false)),
                                                  const SizedBox(width: 15),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) => AlertDialog(
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                            title: const Text("Láminas de seguridad",
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
                                                            content: SizedBox(
                                                              height: 180,
                                                              width: 375,
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                    children: [
                                                                      const SizedBox(height: 25),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child: ElevatedButton(
                                                                          onPressed: () {
                                                                            caller.connectCall(numberLamina);
                                                                          },
                                                                          style: ElevatedButton.styleFrom(
                                                                              shape: const CircleBorder(), backgroundColor: Colors.red, //<-- SEE HERE
                                                                              padding: const EdgeInsets.all(15),
                                                                              alignment: Alignment.center),
                                                                          child: const Icon(
                                                                            Icons.call,
                                                                            size: 50,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(height: 5),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                    children: const [
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child: Padding(
                                                                          padding: EdgeInsets.all(15),
                                                                          child:
                                                                          Text("Call", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(height: 5),
                                                                  const Text(
                                                                      "Pulse para realizar la llamada ",
                                                                      softWrap: true,
                                                                      style: TextStyle(color: Colors.grey))
                                                                ],
                                                              ),
                                                            ),
                                                          ));
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10),
                                                        ), backgroundColor: Colors.blueGrey),
                                                    child: const Icon(Icons.arrow_forward_ios_rounded,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Divider(color: Colors.black),
                                              const SizedBox(height: 15),
                                              Row(
                                                children:[
                                                  const SizedBox(width: 20),
                                                  const Icon(Icons.lock_clock_outlined, size: 30),
                                                  const SizedBox(width: 20),
                                                  const Text('Seguro vehicular\n+593 0991331603',softWrap: true,
                                                      style: TextStyle(fontSize: 20), maxLines: 2,
                                                      textAlign: TextAlign.center,
                                                      textHeightBehavior: TextHeightBehavior(
                                                          applyHeightToFirstAscent: true,
                                                          applyHeightToLastDescent: false)),
                                                  const SizedBox(width: 48),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) => AlertDialog(
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                            title: const Text("Seguro vehicular",
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
                                                            content: SizedBox(
                                                              height: 180,
                                                              width: 375,
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                    children: [
                                                                      const SizedBox(height: 25),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child: ElevatedButton(
                                                                          onPressed: () {
                                                                            caller.connectCall(numberLamina);
                                                                          },
                                                                          style: ElevatedButton.styleFrom(
                                                                              shape: const CircleBorder(), //<-- SEE HERE
                                                                              padding: const EdgeInsets.all(15),
                                                                              primary: Colors.red,
                                                                              alignment: Alignment.center),
                                                                          child: const Icon(
                                                                            Icons.call,
                                                                            size: 50,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(height: 5),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                    children: const [
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child: Padding(
                                                                          padding: EdgeInsets.all(15),
                                                                          child:
                                                                          Text("Call", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(height: 5),
                                                                  const Text(
                                                                      "Pulse para realizar la llamada ",
                                                                      softWrap: true,
                                                                      style: TextStyle(color: Colors.grey))
                                                                ],
                                                              ),
                                                            ),
                                                          ));
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        primary: Colors.blueGrey),
                                                    child: const Icon(Icons.arrow_forward_ios_rounded,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  const Divider(color: Colors.black),
                                                ],
                                              ),
                                              const Divider(color: Colors.black),
                                              const SizedBox(height: 15),
                                              Row(
                                                children:[
                                                  const SizedBox(width: 20),
                                                  const Icon(Icons.local_car_wash, size: 30),
                                                  const SizedBox(width: 20),
                                                  const Text('Mecànica completa\n+593 0991331603',softWrap: true,
                                                      style: TextStyle(fontSize: 20), maxLines: 2,
                                                      textAlign: TextAlign.center,
                                                      textHeightBehavior: TextHeightBehavior(
                                                          applyHeightToFirstAscent: true,
                                                          applyHeightToLastDescent: false)),
                                                  const SizedBox(width: 35),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) => AlertDialog(
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                            title: const Text("Mecànica completa",
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
                                                            content: SizedBox(
                                                              height: 180,
                                                              width: 375,
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                    children: [
                                                                      const SizedBox(height: 25),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child: ElevatedButton(
                                                                          onPressed: () {
                                                                            caller.connectCall(numberLamina);
                                                                          },
                                                                          style: ElevatedButton.styleFrom(
                                                                              shape: const CircleBorder(), //<-- SEE HERE
                                                                              padding: const EdgeInsets.all(15),
                                                                              primary: Colors.red,
                                                                              alignment: Alignment.center),
                                                                          child: const Icon(
                                                                            Icons.call,
                                                                            size: 50,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(height: 5),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                    children: const [
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child: Padding(
                                                                          padding: EdgeInsets.all(15),
                                                                          child:
                                                                          Text("Call", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(height: 5),
                                                                  const Text(
                                                                      "Pulse para realizar la llamada ",
                                                                      softWrap: true,
                                                                      style: TextStyle(color: Colors.grey))
                                                                ],
                                                              ),
                                                            ),
                                                          ));
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        primary: Colors.blueGrey),
                                                    child: const Icon(Icons.arrow_forward_ios_rounded,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  const Divider(color: Colors.black),
                                                ],
                                              ),
                                              const Divider(color: Colors.black),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  ElevatedButton(
                                                      onPressed: () {Navigator.pop(context, exitCode);},
                                                      style: ElevatedButton.styleFrom(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(10),
                                                          ),
                                                          primary: Colors.redAccent),
                                                      child: Container(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 20, vertical: 15),
                                                        child: const Text(
                                                          'Aceptar',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.white),
                                                        ),
                                                      )),
                                                ],

                                              )
                                            ],
                                          ),
                                        ),
                                      ));

                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    primary: Colors.blueGrey),
                                child: const Icon(Icons.arrow_forward_ios_rounded,
                                  size: 20,
                                ))
                          ],
                        ),

                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            const Icon(Icons.key_outlined, size: 30),
                            const Text('Cambiar contraseña', softWrap: true, style: TextStyle(fontSize: 20)),
                            ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        scrollable: true,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        title: const Text(
                                            "Cambia tu contraseña",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold,fontSize: 22)),
                                        content: SizedBox(
                                          height: 330,
                                          width: 500,
                                          child: Column(
                                            children: [
                                              Container(
                                                  padding: const EdgeInsets.only(right: 25, left: 25),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: const [
                                                      Text("Tu contraseña actual", softWrap: true, textAlign: TextAlign.left,
                                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                                                      ),
                                                      SizedBox(height: 5),
                                                      TextField(
                                                        keyboardType: TextInputType.name,
                                                        decoration: InputDecoration(
                                                          contentPadding: EdgeInsets.all(5),
                                                          fillColor: Colors.white,
                                                          filled: true,
                                                          border: OutlineInputBorder(
                                                              borderSide:
                                                              BorderSide(color: Colors.grey, width: 1),
                                                              borderRadius:
                                                              BorderRadius.all(Radius.circular(20))),
                                                        ),
                                                      ),

                                                    ],
                                                  )
                                              ),
                                              const SizedBox(height: 10),
                                              Container(
                                                  padding: const EdgeInsets.only(right: 25, left: 25),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: const [
                                                      Text("Nueva contraseña", softWrap: true, textAlign: TextAlign.left,
                                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                                                      ),
                                                      SizedBox(height: 5),
                                                      TextField(
                                                        keyboardType: TextInputType.name,
                                                        decoration: InputDecoration(
                                                          contentPadding: EdgeInsets.all(5),
                                                          fillColor: Colors.white,
                                                          filled: true,
                                                          border: OutlineInputBorder(
                                                              borderSide:
                                                              BorderSide(color: Colors.grey, width: 1),
                                                              borderRadius:
                                                              BorderRadius.all(Radius.circular(20))),
                                                        ),
                                                      ),

                                                    ],
                                                  )
                                              ),
                                              const SizedBox(height: 10),
                                              Container(
                                                  padding: const EdgeInsets.only(right: 25, left: 25),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: const [
                                                      Text("Repite tu nueva contraseña", softWrap: true, textAlign: TextAlign.left,
                                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                                                      ),
                                                      SizedBox(height: 5),
                                                      TextField(
                                                        keyboardType: TextInputType.name,
                                                        decoration: InputDecoration(
                                                          contentPadding: EdgeInsets.all(5),
                                                          fillColor: Colors.white,
                                                          filled: true,
                                                          border: OutlineInputBorder(
                                                              borderSide:
                                                              BorderSide(color: Colors.grey, width: 1),
                                                              borderRadius:
                                                              BorderRadius.all(Radius.circular(20))),
                                                        ),
                                                      ),

                                                    ],
                                                  )
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    ElevatedButton(
                                                        onPressed: () {Navigator.pop(context, exitCode);},
                                                        style: ElevatedButton.styleFrom(
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(10),
                                                            ),
                                                            primary: Colors.redAccent),
                                                        child: Container(
                                                          padding: const EdgeInsets.symmetric(
                                                              horizontal: 20, vertical: 15),
                                                          child: const Text(
                                                            'Cancelar',
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.white),
                                                          ),
                                                        )),
                                                    const SizedBox(width: 10),
                                                    ElevatedButton(
                                                        onPressed: () {},
                                                        style: ElevatedButton.styleFrom(
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(10),
                                                            ),
                                                            primary: Colors.green),
                                                        child: Container(
                                                          padding: const EdgeInsets.symmetric(
                                                              horizontal: 20, vertical: 15),
                                                          child: const Text(
                                                            'Guardar',
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.white),
                                                          ),
                                                        )),
                                                  ],

                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    primary: Colors.blueGrey),
                                child: const Icon(Icons.arrow_forward_ios_rounded,
                                  size: 20,
                                ))
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            const Icon(Icons.wallpaper, size: 30),
                            const Text('Cambiar fondo', softWrap: true, style: TextStyle(fontSize: 20)),
                            ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        scrollable: true,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        title: const Text(
                                            "Personaliza tu fondo",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold,fontSize: 22)),
                                        content: SizedBox(
                                          height: 330,
                                          width: 500,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children:<Widget>[
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
                                                                children: const [
                                                                  Expanded(
                                                                    flex: 2,
                                                                    child: Icon(Icons.local_hospital_outlined,
                                                                      size: 100,
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                      flex: 1,
                                                                      child: Text('Agregar imagen', style: TextStyle(fontSize: 18, color: Colors.white),
                                                                          textAlign: TextAlign.right, softWrap: true)),
                                                                ],
                                                              ),
                                                            ),
                                                            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const AddBackground()));}
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
                                                              padding: const EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                                                              child: Column(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Image.asset(
                                                                      'images/fondo_ubik.jpg',
                                                                      //height: 150, width: 140,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            onTap: () {},
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  padding: const EdgeInsets.only(left: 25, right: 25),
                                                  child: const Card(
                                                      color: Color(0xffa3a2a9),
                                                      child: Padding(
                                                        padding: EdgeInsets.all(15),
                                                        child: Text('Buscar imagen en la galeria',
                                                          softWrap: true,
                                                          textAlign: TextAlign.justify,
                                                          style: TextStyle(fontSize: 20),
                                                        ),
                                                      )
                                                  )
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  ElevatedButton(
                                                      onPressed: () {Navigator.pop(context, exitCode);},
                                                      style: ElevatedButton.styleFrom(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(10),
                                                          ),
                                                          primary: Colors.redAccent),
                                                      child: Container(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 20, vertical: 15),
                                                        child: const Text(
                                                          'Cancelar',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.white),
                                                        ),
                                                      )),
                                                  const SizedBox(width: 10),
                                                  ElevatedButton(
                                                      onPressed: () {},
                                                      style: ElevatedButton.styleFrom(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(10),
                                                          ),
                                                          primary: Colors.green),
                                                      child: Container(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 20, vertical: 15),
                                                        child: const Text(
                                                          'Guardar',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.white),
                                                        ),
                                                      )),
                                                ],

                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    primary: Colors.blueGrey),
                                child: const Icon(Icons.arrow_forward_ios_rounded,
                                  size: 20,
                                ))
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            const Icon(Icons.handyman, size: 30),
                            const Text('Soporte Técnico', softWrap: true, style: TextStyle(fontSize: 20)),
                            ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                        title: const Text(
                                            "Soporte Técnico",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
                                        content: SizedBox(
                                          height: 290,
                                          width: 500,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children:[
                                                  const SizedBox(width: 20),
                                                  const Icon(Icons.warning, size: 30, color: Colors.red,),
                                                  const SizedBox(width: 20),
                                                  const Text('En caso de robo\n+593 0991331603',softWrap: true,
                                                      style: TextStyle(fontSize: 20), maxLines: 2,
                                                      textAlign: TextAlign.center,
                                                      textHeightBehavior: TextHeightBehavior(
                                                          applyHeightToFirstAscent: true,
                                                          applyHeightToLastDescent: false)),
                                                  const SizedBox(width: 10),
                                                  ElevatedButton(
                                                    onPressed: () {caller.connectCall(numberLamina);},
                                                    style: ElevatedButton.styleFrom(
                                                        shape: const CircleBorder(), //<-- SEE HERE
                                                        padding: const EdgeInsets.all(15),
                                                        primary: Colors.red,
                                                        alignment: Alignment.center),
                                                    child: const Icon(
                                                      Icons.wifi_calling_3,
                                                      size: 22,
                                                  )),
                                                ],
                                              ),
                                              const Divider(color: Colors.black),
                                              const SizedBox(height: 15),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children:[
                                                  const SizedBox(width: 20),
                                                  const Icon(Icons.book_outlined, size: 30, color: Colors.blue,),
                                                  const SizedBox(width: 20),
                                                  const Text('Uso de la app',softWrap: true,
                                                      style: TextStyle(fontSize: 20), maxLines: 2,
                                                      textAlign: TextAlign.center,
                                                      textHeightBehavior: TextHeightBehavior(
                                                          applyHeightToFirstAscent: true,
                                                          applyHeightToLastDescent: false)),
                                                  const SizedBox(width: 48),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) => AlertDialog(
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                            title: const Text("Uso del app",
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
                                                            content: SizedBox(
                                                              height: 250,
                                                              width: 375,
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children:const [
                                                                      SizedBox(width: 10),
                                                                      Icon(Icons.check, size: 30, color: Colors.blue),
                                                                      SizedBox(width: 10),
                                                                      Text('Primeros pasos en la app',softWrap: true,
                                                                          style: TextStyle(fontSize: 20)),
                                                                      SizedBox(width: 30),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(height: 10),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children:const [
                                                                      SizedBox(width: 2),
                                                                      Icon(Icons.check, size: 30, color: Colors.blue),
                                                                      SizedBox(width: 10),
                                                                      Text('Funciones avanzadas',softWrap: true,
                                                                          style: TextStyle(fontSize: 20)),
                                                                      SizedBox(width: 40),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(height: 10),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children:const [
                                                                      SizedBox(width: 10),
                                                                      Icon(Icons.check, size: 30, color: Colors.blue),
                                                                      SizedBox(width: 10),
                                                                      Text('Mantenimiento preventivo',softWrap: true,
                                                                          style: TextStyle(fontSize: 20)),
                                                                      SizedBox(width: 30),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(height: 20),
                                                                  const Text('Encuentra toda la información en:',softWrap: true,
                                                                      style: TextStyle(fontSize: 20)),
                                                                  const Divider(color: Colors.black),
                                                                  const SizedBox(height: 5),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      ElevatedButton(
                                                                          onPressed: () {},
                                                                          style: ElevatedButton.styleFrom(
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius:
                                                                                BorderRadius.circular(10),
                                                                              ),
                                                                              primary: Colors.red),
                                                                          child: Container(
                                                                            padding: const EdgeInsets.symmetric(
                                                                                horizontal: 20, vertical: 15),
                                                                            child: const Icon( Icons.ondemand_video, size: 40,
                                                                            ),
                                                                          )),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ));
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        primary: Colors.blueGrey),
                                                    child: const Icon(Icons.arrow_forward_ios_rounded,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  const Divider(color: Colors.black),
                                                ],
                                              ),
                                              const Divider(color: Colors.black),
                                              const SizedBox(height: 15),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children:[
                                                  const SizedBox(width: 20),
                                                  const Icon(Icons.sms_failed_outlined, size: 30),
                                                  const SizedBox(width: 20),
                                                  const Text('Reportar un fallo',softWrap: true,
                                                      style: TextStyle(fontSize: 20),
                                                      textAlign: TextAlign.center,),
                                                  const SizedBox(width: 35),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) => AlertDialog(
                                                            scrollable: true,
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                            title: const Text("Reportar un fallo",
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
                                                            content: SizedBox(
                                                              height: 420,
                                                              width: 400,
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Checkbox(
                                                                        value: chech1, activeColor: Colors.blue,
                                                                        onChanged: (bool value){
                                                                          setState((){
                                                                            chech1 = value;
                                                                          });
                                                                        },
                                                                      ),
                                                                      const Text(
                                                                          "Se cerro inesperadamente",
                                                                          softWrap: true,
                                                                          style: TextStyle(color: Colors.black)),
                                                                      const SizedBox(width: 15)
                                                                    ],
                                                                  ),
                                                                  const SizedBox(height: 5),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Checkbox(
                                                                        value: chech2, activeColor: Colors.blue,
                                                                        onChanged: (bool value){
                                                                          setState((){
                                                                            chech2 = value;
                                                                          });
                                                                        },
                                                                      ),
                                                                      const Text(
                                                                          "Función con bug",
                                                                          softWrap: true,
                                                                          style: TextStyle(color: Colors.black)),
                                                                      const SizedBox(width: 15)
                                                                    ],
                                                                  ),
                                                                  const SizedBox(height: 5),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Checkbox(
                                                                        value: chech3, activeColor: Colors.blue,
                                                                        onChanged: (bool value){
                                                                          setState((){
                                                                            chech3 = value;
                                                                          });
                                                                        },
                                                                      ),
                                                                      const Text(
                                                                          "App muy lenta",
                                                                          softWrap: true,
                                                                          style: TextStyle(color: Colors.black)),
                                                                      const SizedBox(width: 15)
                                                                    ],
                                                                  ),
                                                                  const SizedBox(height: 5),
                                                                  Container(
                                                                      padding: const EdgeInsets.only(right: 25, left: 25),
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: const [
                                                                          Text("Describe el problema", softWrap: true, textAlign: TextAlign.left,
                                                                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                                                                          ),
                                                                          SizedBox(height: 15),
                                                                          TextField(
                                                                            keyboardType: TextInputType.name,
                                                                            decoration: InputDecoration(
                                                                              contentPadding: EdgeInsets.all(40),
                                                                              fillColor: Colors.white,
                                                                              filled: true,
                                                                              border: OutlineInputBorder(
                                                                                  borderSide:
                                                                                  BorderSide(color: Colors.grey, width: 1),
                                                                                  borderRadius:
                                                                                  BorderRadius.all(Radius.circular(30))),
                                                                            ),
                                                                          ),

                                                                        ],
                                                                      )
                                                                  ),
                                                                  const SizedBox(height: 15),
                                                                  ElevatedButton(
                                                                      onPressed: () {Navigator.pop(context, exitCode);},
                                                                      style: ElevatedButton.styleFrom(
                                                                          shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                            BorderRadius.circular(20),
                                                                          ),
                                                                          primary: Colors.green),
                                                                      child: Container(
                                                                        padding: const EdgeInsets.symmetric(
                                                                            horizontal: 50, vertical: 25),
                                                                        child: const Text(
                                                                          'Enviar',
                                                                          style: TextStyle(
                                                                              fontSize: 20,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.white),
                                                                        ),
                                                                      )),
                                                                ],
                                                              ),
                                                            ),
                                                          ));
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        primary: Colors.blueGrey),
                                                    child: const Icon(Icons.arrow_forward_ios_rounded,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  const Divider(color: Colors.black),
                                                ],
                                              ),
                                              const Divider(color: Colors.black),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  ElevatedButton(
                                                      onPressed: () {Navigator.pop(context, exitCode);},
                                                      style: ElevatedButton.styleFrom(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(10),
                                                          ),
                                                          primary: Colors.redAccent),
                                                      child: Container(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 20, vertical: 15),
                                                        child: const Text(
                                                          'Aceptar',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.white),
                                                        ),
                                                      )),
                                                ],

                                              )
                                            ],
                                          ),
                                        ),
                                      ));

                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    primary: Colors.blueGrey),
                                child: const Icon(Icons.arrow_forward_ios_rounded,
                                  size: 20,
                                ))
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            const Icon(Icons.music_note, size: 30),
                            const Text('Cambia el tono', softWrap: true, style: TextStyle(fontSize: 20)),
                            ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                        title: const Text(
                                            "Cambiar tono",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 25)),
                                        content: SizedBox(
                                          height: 310,
                                          width: 500,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children:[
                                                  Expanded(
                                                    flex: 1,
                                                    child: ElevatedButton(
                                                      onPressed: () {},
                                                      style: ElevatedButton.styleFrom(
                                                          shape: const CircleBorder(), //<-- SEE HERE
                                                          padding: const EdgeInsets.all(15),
                                                          primary: Colors.blue,
                                                          alignment: Alignment.center),
                                                      child: const Icon(
                                                        Icons.music_note,
                                                        size: 30,
                                                      ),
                                                    ),
                                                  ),
                                                  const Text('Tono actual\nUbik-siren1',softWrap: true,
                                                      style: TextStyle(fontSize: 22), maxLines: 2,
                                                      textAlign: TextAlign.center,
                                                      textHeightBehavior: TextHeightBehavior(
                                                          applyHeightToFirstAscent: true,
                                                          applyHeightToLastDescent: false)),
                                                  const SizedBox(width: 100),
                                                ],
                                              ),
                                              const Divider(color: Colors.black),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  ElevatedButton(
                                                      onPressed: () {},
                                                      style: ElevatedButton.styleFrom(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(10),
                                                          ),
                                                          primary: Colors.grey),
                                                      child: Container(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 20, vertical: 15),
                                                        child: const Text(
                                                          'Buscar tono en el teléfono',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.white),
                                                        ),
                                                      )),
                                                ],

                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children:[
                                                  Expanded(
                                                    flex: 1,
                                                    child: ElevatedButton(
                                                      onPressed: () {},
                                                      style: ElevatedButton.styleFrom(
                                                          shape: const CircleBorder(), //<-- SEE HERE
                                                          padding: const EdgeInsets.all(15),
                                                          primary: Colors.blue,
                                                          alignment: Alignment.center),
                                                      child: const Icon(
                                                        Icons.check,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  const SizedBox(width: 10),
                                                  const Text('Bad Bunny - Neverita',softWrap: true,
                                                      style: TextStyle(fontSize: 20)),
                                                  const SizedBox(width: 60),
                                                ],
                                              ),
                                              const SizedBox(height: 20),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  ElevatedButton(
                                                      onPressed: () {Navigator.pop(context, exitCode);},
                                                      style: ElevatedButton.styleFrom(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(10),
                                                          ),
                                                          primary: Colors.redAccent),
                                                      child: Container(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 20, vertical: 15),
                                                        child: const Text(
                                                          'Cancelar',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.white),
                                                        ),
                                                      )),
                                                  const SizedBox(width: 10),
                                                  ElevatedButton(
                                                      onPressed: () {},
                                                      style: ElevatedButton.styleFrom(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(10),
                                                          ),
                                                          primary: Colors.green),
                                                      child: Container(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 20, vertical: 15),
                                                        child: const Text(
                                                          'Guardar',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.white),
                                                        ),
                                                      )),
                                                ],

                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    primary: Colors.blueGrey),
                                child: const Icon(Icons.arrow_forward_ios_rounded,
                                  size: 20,
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      //PRIVACIDAD
                      Container(
                        padding: const EdgeInsets.only(right: 260),
                        child: const Text('PRIVACIDAD', style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 22)),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:const [
                            Icon(Icons. add_location, size: 30),
                            Text('Ubicación', softWrap: true, style: TextStyle(fontSize: 20)),
                            Text('Permitido', softWrap: true, style: TextStyle(fontSize: 20))
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      Container(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: const Card(
                          color: Color(0xffa3a2a9),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text('Es necesario para la aplicación que este activad la ubicación para poder trabajar correctamente.',
                              softWrap: true,
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 20),
                            ),
                          )
                        )
                      ),
                      const SizedBox(height: 25)
                    ],
                  ),
                ),
              )
          ),
        ),
      ),
    );
  }
}