// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ubik_gps_application_flutter/components/buttonIconDesign.dart';
import 'package:ubik_gps_application_flutter/components/cardWidgetInformation.dart';
import 'package:ubik_gps_application_flutter/components/decorationBackground.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_caller.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_smartcare_addbuy.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_whatsapplink.dart';
import 'package:ubik_gps_application_flutter/src/models/getDataVehicle.dart';

class BuyCar extends StatefulWidget{
  const BuyCar({Key key, @required this.token}) : super(key: key);

  final String token;

  @override
  _BuyCarState createState()=> _BuyCarState();
}

class _BuyCarState extends State<BuyCar>{
  ApiSmartCare apiSmartCare = ApiSmartCare();
  ApiWhatsapp apiWhatsapp = ApiWhatsapp();
  ApiCall apiCall = ApiCall();

  List<Widget> buyCars(List<SelfVehicle> data){
    List<Widget> listWidget = [];
    for(var i in data){
      listWidget.add(
          CardWidgetInformation(
            height: 440,
            width: 400,
            radius: 25,
            child: Column(
              children: [
                ListTile(
                  title: Text("${i.marcaModelo} - ${i.year}", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                Image.network("https://www.chevrolet.com.ec/content/dam/chevrolet/south-america/ecuador/espanol/index/cars/01-images/2022-showroom-joy-HB.jpg?imwidth=600", scale: 1),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(i.descripcion, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(width: 45),
                          Text(i.fecha, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                          children: [
                            const Icon(Icons.calendar_month),
                            const SizedBox(width: 5),
                            Text(i.year, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                            const SizedBox(width: 15),
                            const Icon(Icons.speed),
                            const SizedBox(width: 5),
                            Text(i.recorrido, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                            const SizedBox(width: 60),
                            const Icon(Icons.price_change_sharp),
                          ]
                      ),
                      const SizedBox(height: 10),
                      Row(
                          children: const [
                            Icon(Icons.location_on),
                            SizedBox(width: 5),
                            Text("Location car", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                          ]
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                ButtonBar(
                  alignment: MainAxisAlignment.end,
                  children: [
                    ButtonIconWidget(
                      function: (){
                        apiWhatsapp.connectWhatsApp(i.contacto, "Hola, estoy interesado en el vehiculo ${i.marcaModelo} del año ${i.year} a nombre de ${i.nombre}");
                      },
                      iconData: Icons.whatshot,
                      namebutton: "Mensajear",
                      color: const Color(0xff5baf14),
                      circular: 10,
                      size: 30,
                    ),
                    ButtonIconWidget(
                      function: (){
                        apiCall.connectCall(i.contacto);
                      },
                      iconData: Icons.phone,
                      namebutton: "Contactar",
                      color: const Color(0xff3281ce),
                      circular: 10,
                      size: 30,
                    ),
                  ],
                )
              ],
            ),
          )
      );
    }
    return listWidget;
  }

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: DecorationBack.backgroundGradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Column(
            children: const [
              Text("VEHICULOS A LA VENTA"),
              Text("73 vehiculos añadidos"),
            ],
          ),
          centerTitle: true,
          titleTextStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: MediaQuery.of(context).size.height*0.02),
          child: FutureBuilder<List<SelfVehicle>>(
            future: apiSmartCare.getVehicle(http.Client(), widget.token),
            builder: (ctx, snapshot){
              if(snapshot.hasData){
                return ListView(
                  children: buyCars(snapshot.data)
                );
              }
              else if(snapshot.hasError){
                return const Center(child: CircularProgressIndicator());
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}