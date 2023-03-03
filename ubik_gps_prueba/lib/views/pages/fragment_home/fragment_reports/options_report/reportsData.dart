// ignore_for_file: public_member_api_docs, library_private_types_in_public_api, camel_case_types
import 'package:flutter/material.dart';
import 'package:ubik_gps_application_flutter/components/decorationBackground.dart';
import 'package:ubik_gps_application_flutter/src/models/sharedPreferencesClass.dart';

class reportData extends StatefulWidget {
  const reportData({Key key}) : super(key: key);

  @override
  _reportDataState createState() => _reportDataState();
}

class _reportDataState extends State<reportData> {
  UserPreferences userPreferences = UserPreferences();
  String name = 'GRABIEL MERIZALDE';

  DateTimeRange dateTimeRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now()
  );

  @override
  void initState() {
    super.initState();
  }

  String deviceListen;
  List deviceItemListen = ["Detalles", "Rutas", "Eventos", "Paradas", "Viajes"];

  @override
  Widget build(BuildContext context) {
    final diference = dateTimeRange.duration;

    return Container(
      decoration: DecorationBack.backgroundGradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Column(
            children: [Text(name), const Text('Reporte')],
          ),
          centerTitle: true,
          titleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
          backgroundColor: Colors.transparent,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: TextButton.icon(
                onPressed: () async {
                  DateTimeRange newDateRange = await showDateRangePicker(
                      context: context,
                      initialDateRange: dateTimeRange,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2999),
                      builder: (context, child){
                        return Theme(data: ThemeData.dark(), child: child);
                      }
                  );
                  if(newDateRange == null){return;}
                  setState(()=> dateTimeRange = newDateRange);
                },
                icon: const Icon(Icons.calendar_month, color: Colors.white, size: 30),
                label: diference == null ? const Text('DATOS PREVIOS', style: TextStyle(fontSize: 20, color: Colors.white)) : Text('ULTIMOS ${diference.inDays} DIAS', style: const TextStyle(fontSize: 20, color: Colors.white)),
              )
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height*0.02,
                right: 10,
                left: 10,
                bottom: 60
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  elevation: 10,
                  child: Container(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        color: const Color(0xff89898c),
                        borderRadius: BorderRadius.circular(25)
                    ),
                    child: DropdownButton(
                      underline: Container(
                          decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide.none)
                          )
                      ),
                      hint: const Text("Selecione una opcion: ", style: TextStyle(color: Colors.white)),
                      icon: const Icon(Icons.arrow_drop_down_circle),
                      iconSize: 40,
                      dropdownColor: Colors.grey,
                      isExpanded: true,
                      value: deviceListen,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                      onChanged: (value){
                        setState((){
                          deviceListen = value;
                        });
                      },
                      items: deviceItemListen.map((valueItem){
                        return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem, style: const TextStyle(color: Colors.white))
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  elevation: 10,
                  child: Container(
                    padding: const EdgeInsets.only(right: 10, left: 10, top: 15, bottom: 15),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Image.asset('images/medico.png', height: 60, width: 60, color: const Color(0xff2a317a)),
                        ),
                        Flexible(
                          flex: 3,
                          fit: FlexFit.tight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("online DON ARTURO", style: TextStyle(fontSize: 20), softWrap: true),
                              Text("MW0923AH28", style: TextStyle(fontSize: 20), softWrap: true),
                            ],
                          ),
                        )
                      ],
                    )
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  elevation: 10,
                  child: Container(
                      padding: const EdgeInsets.only(right: 10, left: 10, top: 15, bottom: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: const [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Icon(Icons.label, color: Color(0xff2a317a)),
                              ),
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: Text("Tipo de dispositivo", style: TextStyle(fontSize: 18), softWrap: true),
                              ),
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: Text("No hay datos", style: TextStyle(fontSize: 18), softWrap: true,),
                              ),
                            ],
                          ),
                          Row(
                            children: const [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Icon(Icons.speed, color: Color(0xff2a317a)),
                              ),
                              Flexible(
                                flex: 4,
                                fit: FlexFit.tight,
                                child: Text("123 km/h", style: TextStyle(fontSize: 18), softWrap: true),
                              ),
                            ],
                          ),
                          Row(
                            children: const [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Icon(Icons.location_on_outlined, color: Color(0xff2a317a)),
                              ),
                              Flexible(
                                flex: 4,
                                fit: FlexFit.tight,
                                child: Text("Latitud: -2.18333", style: TextStyle(fontSize: 18), softWrap: true),
                              ),
                            ],
                          ),
                          Row(
                            children: const [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Icon(Icons.location_on_outlined, color: Color(0xff2a317a)),
                              ),
                              Flexible(
                                flex: 4,
                                fit: FlexFit.tight,
                                child: Text("Longitud: -78.333", style: TextStyle(fontSize: 18), softWrap: true),
                              ),
                            ],
                          ),
                          Row(
                            children: const [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Icon(Icons.turn_right_rounded, color: Color(0xff169a05)),
                              ),
                              Flexible(
                                flex: 4,
                                fit: FlexFit.tight,
                                child: Text("22/11/2022 03:25:87 PM", style: TextStyle(fontSize: 18), softWrap: true),
                              ),
                            ],
                          ),
                          Row(
                            children: const [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Icon(Icons.turn_right_rounded, color: Color(0xfff81b1b)),
                              ),
                              Flexible(
                                flex: 4,
                                fit: FlexFit.tight,
                                child: Text("22/11/2022 03:25:87 PM", style: TextStyle(fontSize: 18), softWrap: true),
                              ),
                            ],
                          ),
                          const SizedBox(height: 60),
                          Row(
                            children: const [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Icon(Icons.location_on_sharp, color: Color(0xff2a317a)),
                              ),
                              Flexible(
                                flex: 4,
                                fit: FlexFit.tight,
                                child: Text("Cdla los sauces 4 principal NO", style: TextStyle(fontSize: 18), softWrap: true),
                              ),
                            ],
                          ),
                        ],
                      )
                  ),
                ),
                const SizedBox(height: 10),
                const Text("SENSORES", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xffe4e4ea)), textAlign: TextAlign.center),
                const SizedBox(height: 10),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  elevation: 10,
                  child: Container(
                      padding: const EdgeInsets.only(right: 15, left: 15, top: 20, bottom: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Status", style: TextStyle(fontSize: 18), softWrap: true),
                              Text("5", style: TextStyle(fontSize: 18), softWrap: true)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Ignition", style: TextStyle(fontSize: 18), softWrap: true),
                              Text("false", style: TextStyle(fontSize: 18), softWrap: true)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Charge", style: TextStyle(fontSize: 18), softWrap: true),
                              Text("true", style: TextStyle(fontSize: 18), softWrap: true)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Blocked", style: TextStyle(fontSize: 18), softWrap: true),
                              Text("false", style: TextStyle(fontSize: 18), softWrap: true)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Battery level", style: TextStyle(fontSize: 18), softWrap: true),
                              Text("100", style: TextStyle(fontSize: 18), softWrap: true)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("RSSI", style: TextStyle(fontSize: 18), softWrap: true),
                              Text("5", style: TextStyle(fontSize: 18), softWrap: true)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Distance", style: TextStyle(fontSize: 18), softWrap: true),
                              Text("0.0 km", style: TextStyle(fontSize: 18), softWrap: true)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Total distance", style: TextStyle(fontSize: 18), softWrap: true),
                              Text("21130.2 km", style: TextStyle(fontSize: 18), softWrap: true)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Motion", style: TextStyle(fontSize: 18), softWrap: true),
                              Text("false", style: TextStyle(fontSize: 18), softWrap: true)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Hours", style: TextStyle(fontSize: 18), softWrap: true),
                              Text("5633 hr 48 min", style: TextStyle(fontSize: 18), softWrap: true)
                            ],
                          ),
                        ],
                      )
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
