// ignore_for_file: public_member_api_docs, library_private_types_in_public_api, camel_case_types
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ubik_gps_application_flutter/components/decorationBackground.dart';
import 'package:ubik_gps_application_flutter/src/models/sharedPreferencesClass.dart';

class abstractData extends StatefulWidget {
  const abstractData({Key key}) : super(key: key);

  @override
  _abstractDataState createState() => _abstractDataState();
}

class _abstractDataState extends State<abstractData> {
  UserPreferences userPreferences = UserPreferences();
  String name = 'GABRIEL MERIZALDE';

  DateTimeRange dateTimeRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now()
  );


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final start = dateTimeRange.start;
    final end = dateTimeRange.end;
    final diference = dateTimeRange.duration;

    return Container(
      decoration: DecorationBack.backgroundGradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title:const Text('Resumen'),
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
            padding: const EdgeInsets.only(right: 0, left: 0, top: 40, bottom: 40),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 125,
                          width: 150,
                          child: Card(
                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                            elevation: 10,
                            color: const Color(0xff5e83cc),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height* 0.01,
                                  left: MediaQuery.of(context).size.width * 0.02,
                                  right: MediaQuery.of(context).size.width * 0.02,
                                  bottom: MediaQuery.of(context).size.height * 0.01
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: MediaQuery.of(context).size.height*0.002),
                                  const Expanded(flex: 1, child: Text("32", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white))),
                                  const Expanded(flex: 1, child: Text("Viajes", style: TextStyle(fontSize: 22, color: Colors.white), softWrap: false, overflow: TextOverflow.ellipsis, maxLines: 4, textAlign: TextAlign.center)),
                                  const Expanded(flex: 1, child: Icon(Icons.polyline_outlined, color: Colors.white, size: 40)),
                                  SizedBox(height: MediaQuery.of(context).size.height*0.01),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 125,
                          width: 150,
                          child: Card(
                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                            elevation: 10,
                            color: const Color(0xff3d559d),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height* 0.01,
                                  left: MediaQuery.of(context).size.width * 0.02,
                                  right: MediaQuery.of(context).size.width * 0.02,
                                  bottom: MediaQuery.of(context).size.height * 0.01
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: MediaQuery.of(context).size.height*0.002),
                                  const Expanded(flex: 1, child: Text("453.21", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white))),
                                  const Expanded(flex: 1, child: Text("Recorrido (km)", style: TextStyle(fontSize: 22, color: Colors.white), softWrap: false, overflow: TextOverflow.ellipsis, maxLines: 4, textAlign: TextAlign.center)),
                                  const Expanded(flex: 1, child: Icon(Icons.route, color: Colors.white, size: 40)),
                                  SizedBox(height: MediaQuery.of(context).size.height*0.01),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 125,
                          width: 150,
                          child: Card(
                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                            elevation: 10,
                            color: const Color(0xff5e83cc),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height* 0.01,
                                  left: MediaQuery.of(context).size.width * 0.02,
                                  right: MediaQuery.of(context).size.width * 0.02,
                                  bottom: MediaQuery.of(context).size.height * 0.01
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: MediaQuery.of(context).size.height*0.002),
                                  const Expanded(flex: 1, child: Text("32", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white))),
                                  const Expanded(flex: 2, child: Text("Exceso de velocidad", style: TextStyle(fontSize: 22, color: Colors.white), softWrap: false, overflow: TextOverflow.ellipsis, maxLines: 4, textAlign: TextAlign.center)),
                                  const Expanded(flex: 1, child: Icon(Icons.speed, color: Colors.white, size: 40)),
                                  SizedBox(height: MediaQuery.of(context).size.height*0.01),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 260,
                          width: 150,
                          child: Card(
                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                            elevation: 10,
                            color: const Color(0xff3d559d),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height* 0.01,
                                  left: MediaQuery.of(context).size.width * 0.02,
                                  right: MediaQuery.of(context).size.width * 0.02,
                                  bottom: MediaQuery.of(context).size.height * 0.01
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: MediaQuery.of(context).size.height*0.05),
                                  const Expanded(flex: 1, child: Text("89", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white))),
                                  const Expanded(flex: 1, child: Text("Puntaje de conduccion", style: TextStyle(fontSize: 24, color: Colors.white), softWrap: false, overflow: TextOverflow.ellipsis, maxLines: 4, textAlign: TextAlign.center)),
                                  const Expanded(flex: 1, child: Icon(Icons.drive_eta_outlined, color: Colors.white, size: 60)),
                                  SizedBox(height: MediaQuery.of(context).size.height*0.05),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 125,
                          width: 150,
                          child: Card(
                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                            elevation: 10,
                            color: const Color(0xff3d559d),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height* 0.01,
                                  left: MediaQuery.of(context).size.width * 0.02,
                                  right: MediaQuery.of(context).size.width * 0.02,
                                  bottom: MediaQuery.of(context).size.height * 0.01
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: MediaQuery.of(context).size.height*0.002),
                                  const Expanded(flex: 1, child: Text("9", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white))),
                                  const Expanded(flex: 2, child: Text("Frenados bruscos", style: TextStyle(fontSize: 22, color: Colors.white), softWrap: false, overflow: TextOverflow.ellipsis, maxLines: 4, textAlign: TextAlign.center)),
                                  const Expanded(flex: 1, child: Icon(Icons.speed, color: Colors.white, size: 40)),
                                  SizedBox(height: MediaQuery.of(context).size.height*0.01),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 125,
                          width: 150,
                          child: Card(
                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                            elevation: 10,
                            color: const Color(0xff5e83cc),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height* 0.01,
                                  left: MediaQuery.of(context).size.width * 0.02,
                                  right: MediaQuery.of(context).size.width * 0.02,
                                  bottom: MediaQuery.of(context).size.height * 0.01
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: MediaQuery.of(context).size.height*0.002),
                                  const Expanded(flex: 1, child: Text("26.95", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white))),
                                  const Expanded(flex: 1, child: Text("Consumo (\$)", style: TextStyle(fontSize: 22, color: Colors.white), softWrap: false, overflow: TextOverflow.ellipsis, maxLines: 4, textAlign: TextAlign.center)),
                                  const Expanded(flex: 1, child: Icon(Icons.oil_barrel, color: Colors.white, size: 40)),
                                  SizedBox(height: MediaQuery.of(context).size.height*0.01),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 125,
                          width: 150,
                          child: Card(
                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                            elevation: 10,
                            color: const Color(0xff3d559d),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height* 0.01,
                                  left: MediaQuery.of(context).size.width * 0.02,
                                  right: MediaQuery.of(context).size.width * 0.02,
                                  bottom: MediaQuery.of(context).size.height * 0.01
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: MediaQuery.of(context).size.height*0.002),
                                  const Expanded(flex: 1, child: Text("32", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white))),
                                  const Expanded(flex: 2, child: Center(child: Text("Velocidad promedio(km/h)", style: TextStyle(fontSize: 20, color: Colors.white), softWrap: false, overflow: TextOverflow.ellipsis, maxLines: 4, textAlign: TextAlign.center))),
                                  const Expanded(flex: 1, child: Icon(Icons.speed, color: Colors.white, size: 40)),
                                  SizedBox(height: MediaQuery.of(context).size.height*0.01),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 125,
                          width: 150,
                          child: Card(
                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                            elevation: 10,
                            color: const Color(0xff5e83cc),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height* 0.01,
                                  left: MediaQuery.of(context).size.width * 0.02,
                                  right: MediaQuery.of(context).size.width * 0.02,
                                  bottom: MediaQuery.of(context).size.height * 0.01
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: MediaQuery.of(context).size.height*0.002),
                                  const Expanded(flex: 1, child: Text("26", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white))),
                                  const Expanded(flex: 2, child: Text("Aceleracion brusca", style: TextStyle(fontSize: 22, color: Colors.white), softWrap: false, overflow: TextOverflow.ellipsis, maxLines: 4, textAlign: TextAlign.center)),
                                  const Expanded(flex: 1, child: Icon(Icons.speed, color: Colors.white, size: 40)),
                                  SizedBox(height: MediaQuery.of(context).size.height*0.01),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    children: [
                      const Text("Ubicacion del vehiculo", style: TextStyle(fontSize: 24, color: Colors.white)),
                      const Text("Sabado 25 nov 2022, 13:15:14", style: TextStyle(fontSize: 24, color: Colors.white)),
                      const SizedBox(height: 25),
                      SizedBox(
                        height: 125,
                        width: 150,
                        child: Card(
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                          elevation: 10,
                          color: const Color(0xff2643ce),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                          child: Container(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height* 0.01,
                                left: MediaQuery.of(context).size.width * 0.02,
                                right: MediaQuery.of(context).size.width * 0.02,
                                bottom: MediaQuery.of(context).size.height * 0.01
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: MediaQuery.of(context).size.height*0.002),
                                const Expanded(flex: 2, child: Icon(Icons.play_arrow_outlined, color: Colors.white, size: 70)),
                                const Expanded(flex: 1, child: Text("Play Back", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white))),
                                SizedBox(height: MediaQuery.of(context).size.height*0.01),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
