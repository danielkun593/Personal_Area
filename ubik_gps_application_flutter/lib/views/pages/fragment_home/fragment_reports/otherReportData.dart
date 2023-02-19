// ignore_for_file: public_member_api_docs, library_private_types_in_public_api, camel_case_types
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:ubik_gps_application_flutter/components/decorationBackground.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_devicelist.dart';
import 'package:ubik_gps_application_flutter/src/models/deviceClass.dart';
import 'package:ubik_gps_application_flutter/src/models/sharedPreferencesClass.dart';
import 'package:ubik_gps_application_flutter/views/pages/fragment_home/fragment_reports/options_report/abstractData.dart';
import 'package:ubik_gps_application_flutter/views/pages/fragment_home/fragment_reports/options_report/reportsData.dart';

class otherReport extends StatefulWidget {
  const otherReport({Key key}) : super(key: key);

  @override
  _otherReportState createState() => _otherReportState();
}

class _otherReportState extends State<otherReport> {
  Future<List<Device>> listDispotivos;
  String name = '';
  String currentAddress = '';
  Position currentPosition;
  LatLng coordinate;
  double lat = 0.0, lon = 0.0;
  ApiDevice deviceApi = ApiDevice();
  UserPreferences userPreferences = UserPreferences();

  Future<void> getAddressPosition(Position position) async {
    await placemarkFromCoordinates(currentPosition.latitude, currentPosition.longitude, localeIdentifier: "en").then((List<Placemark> placemark){
      Placemark place = placemark[0];
      setState(() {
        currentAddress = "${place.street}, ${place.subAdministrativeArea}, ${place.locality}, ${place.country}";
        //print(currentAddress);
      });
    });
    return currentAddress;
  }

  @override
  void initState() {
    super.initState();
    listDispotivos = deviceApi.deviceUser();
  }

  List<Widget> listDispositivos(List<Device> data) {
    List<Widget> listWidget = [];
    for (var item in data) {
      if(item.statusDevice == "unknown"){
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
                          item.statusDevice == 'online' ? const Icon(Icons.circle, color: Colors.green) : const Icon(Icons.circle, color: Colors.red,
                          ),
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
                          Text("Locations: ${item.latitude}, ${item.longitude}")
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                  ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), topLeft: Radius.circular(5)),
                        ))),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const abstractData()));
                    },
                    icon: const Icon(
                      Icons.receipt,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "RESUMEN",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const reportData()));
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), topRight: Radius.circular(5)),
                        ))),
                    icon: const Icon(
                      Icons.report,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "REPORTES",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ])
              ],
            )));
      }
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
          child: FutureBuilder(
              future: listDispotivos,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                      children: listDispositivos(snapshot.data)
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
