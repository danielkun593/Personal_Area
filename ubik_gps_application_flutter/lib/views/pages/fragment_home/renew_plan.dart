// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ubik_gps_application_flutter/components/buttonDesign.dart';
import 'package:ubik_gps_application_flutter/components/circularButton.dart';
import 'package:ubik_gps_application_flutter/components/decorationBackground.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_assesorlist.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_caller.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_renewplan.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_whatsapplink.dart';
import 'package:ubik_gps_application_flutter/src/models/getAsessor.dart';
import 'package:ubik_gps_application_flutter/src/models/getRenewPlan.dart';

class RenewPlan extends StatefulWidget {
  const RenewPlan({Key key, @required this.token}) : super(key: key);

  final String token;

  @override
  _RenewPlanState createState() => _RenewPlanState();
}

class _RenewPlanState extends State<RenewPlan>{
  String numberPhone = "";
  String asesor = "Asesoria Comercial";
  ApiCall functionPhone = ApiCall();
  ApiWhatsapp whatsapp = ApiWhatsapp();
  ApiRenew apiRenew = ApiRenew();
  ApiAssesor apiAssesor = ApiAssesor();
  Future<List<GetRenewPlan>> listDataPlan;
  Future<List<Assesor>> listAssesor;

  @override
  void initState() {
    super.initState();
  }


  infoRenovar (List<GetRenewPlan> data){
    Widget cardInformation;
    for(var i in data){
      cardInformation = SizedBox(
        height: 225,
        width: 400,
        child: Column(
          children: [
            Table(
              border: TableBorder.all(color: Colors.grey, width: 1.5),
              columnWidths: const {
                0: FlexColumnWidth(4),
                1: FlexColumnWidth(7)
              },
              children: [
                TableRow(
                  children: [
                    const Text("Cliente", softWrap: true, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    Text(i.name, softWrap: true, style: const TextStyle(fontSize: 22, color: Colors.grey)),
                  ]
                ),
                TableRow(
                    children: [
                      const Text("Correo electronico", softWrap: true, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      Text(i.email, softWrap: true, style: const TextStyle(fontSize: 22, color: Colors.grey)),
                    ]
                ),
                TableRow(
                    children: [
                      const Text("Telefono", softWrap: true, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      Text(i.phone, softWrap: true, style: const TextStyle(fontSize: 22, color: Colors.grey)),
                    ]
                ),
                TableRow(
                    children: [
                      const Text("Dispositivos", softWrap: true, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      Text("Posee ${i.dispositivos} dispositivos", softWrap: true, style: const TextStyle(fontSize: 22, color: Colors.grey)),
                    ]
                ),
                TableRow(
                    children: [
                      const Text("Plan", softWrap: true, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      Text(i.plan, softWrap: true, style: const TextStyle(fontSize: 22, color: Colors.grey)),
                    ]
                ),
                TableRow(
                    children: [
                      const Text("Costo", softWrap: true, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      Text("\$ ${i.value}", softWrap: true, style: const TextStyle(fontSize: 22, color: Colors.grey)),
                    ]
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Text("Detalles del servicio actual contratado, para mas informacion contactarse con el asesor comercial.",
              softWrap: true,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }
    return cardInformation;
  }
  infoAsesor (List<Assesor> data){
    Widget asesorInformation;
    for(var i in data){
      asesorInformation = SizedBox(
            height: 225,
            width: 375,
            child: Column(
              children: [
                Text("Asesor: Sr/a. ${i.name}", softWrap: true, style: const TextStyle(fontSize: 22, color: Colors.grey)),
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
                          functionPhone.connectCall('0${i.phone}');
                        },
                        color: Colors.red,
                        iconData: Icons.phone,
                        nameButton: "Llamar",
                        size: 50,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                const Text(
                    "Dependiendo de la emergencia elige el servicio que sea mas conveniente",
                    softWrap: true,
                    style: TextStyle(color: Colors.grey))
              ],
            ),
          );
    }
    return asesorInformation;
  }
  infoCarga(){
    Widget cardCarga;
    cardCarga = const SizedBox(
      height: 225,
      width: 375,
      child: Center(child: CircularProgressIndicator()),
    );
    return cardCarga;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: DecorationBack.backgroundGradient,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text("RENOVAR PLAN"),
            titleTextStyle: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
            backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height*0.03,
                  right: 15, left: 15, bottom: 40),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        const Text('ESTADO DE CUENTA', softWrap: true, textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30),
                          child: Expanded(
                              flex: 1,
                              child: Column(children: [
                                const Text(
                                    "Estimado Martin Luther King, su servicio esta disponible hasta el 15/05/2022",
                                    softWrap: true,
                                    style: TextStyle(fontSize: 20, color: Colors.grey)),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: Image.asset(
                                            'images/regalo.png')),
                                    const SizedBox(width: 10),
                                    Flexible(
                                        flex: 2,
                                        fit: FlexFit.tight,
                                        child: Column(children: [
                                          const Text(
                                              'Puede obtener un 20% de descuento si actualiza su plan hasta el 15/05/2024',
                                              softWrap: true,
                                              style: TextStyle(fontSize: 20, color: Colors.grey)),
                                          const SizedBox(height: 15),
                                          ButtonWidget(
                                            function: (){
                                              //listDataPlan = apiRenew.dataRenew();
                                              showDialog(
                                                  context: context,
                                                  builder: (context) => AlertDialog(
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                    title: const Text("ESTADO DE CUENTAS",
                                                        textAlign: TextAlign.center, style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
                                                    content: FutureBuilder(
                                                        future: apiRenew.dataRenew(http.Client(), widget.token),
                                                        builder: (context, snapshot){
                                                          if(snapshot.hasData){
                                                            return infoRenovar(snapshot.data);
                                                          }else if(snapshot.hasError){
                                                            return infoCarga();
                                                          }
                                                          return infoCarga();
                                                        }
                                                    ),
                                                  ));
                                            },
                                            namebutton: "Renovar Plan",
                                            color: Colors.green,
                                            circular: 10,
                                            width: 25,
                                            height: 15,
                                          ),
                                        ])),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                const Text('ACERCA DE NOSOTROS', softWrap: true, textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey,),
                                ),
                                const SizedBox(height: 15),
                                const Text(
                                    "Somos una empresa dedicada a la seguridad de siniestros vehiculares.",
                                    softWrap: true,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(fontSize: 20, color: Colors.grey)),
                                const Text(
                                    "Puede consultar las polizas de seguros que mas se adapte a ti con el respaldo de un broker de seguros.",
                                    softWrap: true,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(fontSize: 20, color: Colors.grey)),
                                const SizedBox(height: 15),
                                ButtonWidget(
                                  function: (){
                                    setState(() {
                                      //listAssesor = apiAssesor.asesorUser(asesor);
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                            title: const Text("ASESOR COMERCIAL",
                                                textAlign: TextAlign.center, style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
                                            content: FutureBuilder(
                                                future: apiAssesor.asesorUser(http.Client(), asesor, widget.token),
                                                builder: (ctx, snapshot){
                                                  if(snapshot.hasData){
                                                    return infoAsesor(snapshot.data);
                                                  }else if(snapshot.hasError){
                                                    return infoCarga();
                                                  }
                                                  return infoCarga();
                                                }
                                            ),
                                          ));
                                    });
                                  },
                                  height: 14,
                                  width: 30,
                                  circular: 10,
                                  color: Colors.green,
                                  namebutton: "Asesor Comercial",
                                ),
                              ])),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.05),
                  Image.asset('images/phone_ubiccation_gps.png', height: 250)
                ],
              ),
            ),
          )
      ),
    );
  }
}