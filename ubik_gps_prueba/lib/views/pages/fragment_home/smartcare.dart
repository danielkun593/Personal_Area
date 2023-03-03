// ignore_for_file: deprecated_member_use, library_private_types_in_public_api, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ubik_gps_application_flutter/components/buttonDesign.dart';
import 'package:ubik_gps_application_flutter/components/circularButton.dart';
import 'package:ubik_gps_application_flutter/components/decorationBackground.dart';
import 'package:ubik_gps_application_flutter/components/textString.dart';
import 'package:ubik_gps_application_flutter/icons/icon_create.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_assesorlist.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_caller.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_whatsapplink.dart';
import 'package:ubik_gps_application_flutter/src/models/getAsessor.dart';
import 'package:ubik_gps_application_flutter/views/pages/fragment_home/fragment_smart_care/add_car.dart';
import 'package:ubik_gps_application_flutter/views/pages/fragment_home/fragment_smart_care/buy_car.dart';

class SmartCare extends StatefulWidget {
  const SmartCare({Key key, @required this.token}) : super(key: key);

  final String token;

  @override
  _SmartCareState createState() => _SmartCareState();
}

//CONNECTION WITH WHATSAPP APPLICATIONS OF ASSESOR
class _SmartCareState extends State<SmartCare> {
  ApiAssesor connect_api = ApiAssesor();
  ApiWhatsapp whatsapp = ApiWhatsapp();
  ApiCall caller = ApiCall();
  List<String> typeAsesoria = ["Asesoria de siniestros", "Venta de vehiculo", "Asistencia mecanica", "Matenimiento"];

  infoAsesor (List<Assesor> data){
    Widget cardInformation;
    for(var i in data){
      cardInformation =
          SizedBox(
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
                          caller.connectCall('0${i.phone}');
                        },
                        color: Colors.red,
                        iconData: Icons.phone,
                        nameButton: "Llamar",
                        size: 50,
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: CircularButton(
                        function: null,
                        color: Colors.red,
                        iconData: Icons.edit_document,
                        nameButton: "Formulario",
                        size: 50,
                      ),
                    ),
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
    return cardInformation;
  }
  infoCarga(){
    Widget cardCarga;
    cardCarga =
        const SizedBox(
          height: 225,
          width: 375,
          child: Center(child: CircularProgressIndicator()),
        );
    return cardCarga;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: DecorationBack.backgroundGradient,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const TextString(text: "SmartCare"),
            backgroundColor: Colors.transparent,
            elevation: 10,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 40),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 185,
                    width: 450,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 10,
                      child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              const Text('AESORIA JURIDICA EN SINIESTRO',
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color.fromRGBO(30, 65, 96, 50)),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Image(
                                          image: AssetImage('images/asesoria_juridica.png'),
                                          height: 100,
                                          width: 25,
                                          color: Color.fromRGBO(78, 76, 76, 50))),
                                  Flexible(
                                      flex: 2,
                                      fit: FlexFit.tight,
                                      child: Column(
                                          children: [
                                            const Text('Contactese rapidamente con nosotros dale al boton',
                                            softWrap: true,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 18, color: Colors.grey)),
                                            const SizedBox(height: 20),
                                            ButtonWidget(
                                              function: (){
                                                setState((){
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) => AlertDialog(
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                        title: const Text("ASESORIA JURIDICA EN SINISTRO",
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
                                                        content: FutureBuilder<List<Assesor>>(
                                                            future: connect_api.asesorUser(http.Client(), typeAsesoria[0], widget.token),
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
                                              height: 15,
                                              width: 25,
                                              circular: 10,
                                              color: const Color.fromRGBO(76, 142, 48, 20),
                                              namebutton: "Consultar",
                                            ),
                                          ]
                                      )
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 185,
                    width: 450,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 10,
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              const Text(
                                'AUTO SUSTITUTO',
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color.fromRGBO(30, 65, 96, 50)),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Image(
                                        image: AssetImage('images/carro_sustituto.png'),
                                        height: 100,
                                        width: 25,
                                        color: Color.fromRGBO(78, 76, 76, 50),
                                      )),
                                  Flexible(
                                      flex: 2,
                                      fit: FlexFit.tight,
                                      child: Column(children: [
                                        const Text('No te quedes sin tu carro mientras el tuyo esta en reparaciones',
                                            softWrap: true,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 18, color: Colors.grey)),
                                        const SizedBox(height: 15),
                                        ButtonWidget(
                                          function: (){
                                            setState((){
                                              showDialog(
                                                  context: context,
                                                  builder: (context) => AlertDialog(
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                    title: const Text("AUTO SUSTITUTO",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
                                                    content: SizedBox(
                                                      height: 225,
                                                      width: 375,
                                                      child: FutureBuilder<List<Assesor>>(
                                                          future: connect_api.asesorUser(http.Client(), typeAsesoria[1], widget.token),
                                                          builder: (ctx, snapshot){
                                                            if(snapshot.hasData){
                                                              return infoAsesor(snapshot.data);
                                                            }else if(snapshot.hasError){
                                                              return infoCarga();
                                                            }
                                                            return infoCarga();
                                                          }
                                                      ),
                                                    ),
                                                  ));
                                            });
                                          },
                                          circular: 10,
                                          height: 15,
                                          width: 25,
                                          color: const Color.fromRGBO(76, 142, 48, 20),
                                          namebutton: "Consultar",
                                        ),
                                      ]))
                                ],
                              )
                            ],
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 185,
                    width: 450,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 10,
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              const Text(
                                'ASESORIA COMPRA Y VENTA',
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color.fromRGBO(30, 65, 96, 50)),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Image(
                                        image: AssetImage('images/carro_compra_vental.png'),
                                        height: 100,
                                        width: 25,
                                        color: Color.fromRGBO(78, 76, 76, 50),
                                      )),
                                  Flexible(
                                      flex: 2,
                                      fit: FlexFit.tight,
                                      child: Column(children: [
                                        const Text('Necesitas comprar o vender un carro, consulta aqui',
                                            softWrap: true,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 18, color: Colors.grey)),
                                        const SizedBox(height: 20),
                                        ButtonWidget(
                                          function: (){
                                            showDialog(
                                                context: context,
                                                builder: (context) => AlertDialog(
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                  title: const Text(
                                                      "ASESORIA COMPRA Y VENTA",
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
                                                              child: CircularButton(
                                                                function: (){
                                                                  Navigator.push(context,
                                                                      MaterialPageRoute(builder: (context) => AddCar(token: widget.token)));
                                                                },
                                                                iconData: Icons.add_a_photo,
                                                                nameButton: "Añadir \nvehiculo",
                                                                color: Colors.red,
                                                                size: 50,
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: CircularButton(
                                                                function: (){
                                                                  Navigator.push(context,
                                                                      MaterialPageRoute(builder: (context) => BuyCar(token: widget.token)));
                                                                },
                                                                iconData: Icomoon.carUbik,
                                                                nameButton: "Compra tu \nnuevo vehiculo",
                                                                color: Colors.red,
                                                                size: 50,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(height: 10),
                                                        const Text(
                                                            "Dependiendo de la emergencia elige el servicio que sea mas conveniente",
                                                            softWrap: true,
                                                            style: TextStyle(color: Colors.grey))
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                          },
                                          namebutton: "Consultar",
                                          color: const Color.fromRGBO(76, 142, 48, 20),
                                          width: 25,
                                          height: 15,
                                          circular: 10,
                                        ),
                                      ]))
                                ],
                              )
                            ],
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 185,
                    width: 450,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 10,
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              const Text(
                                'ASESORIA MECANICA Y COLISIONES',
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color.fromRGBO(30, 65, 96, 50)),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Image(
                                        image: AssetImage('images/asesoria_mecanica.png'),
                                        height: 100,
                                        width: 25,
                                        color: Color.fromRGBO(78, 76, 76, 50),
                                      )),
                                  Flexible(
                                      flex: 2,
                                      fit: FlexFit.tight,
                                      child: Column(children: [
                                        const Text('Puedes encontrar todo en nustro taller',
                                            softWrap: true,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 18, color: Colors.grey)),
                                        const SizedBox(height: 20),
                                        ButtonWidget(
                                          function: (){
                                            setState(() {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) => AlertDialog(
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                    title: const Text("ASESORIA MECANICA Y COLISIONES",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
                                                    content: FutureBuilder<List<Assesor>>(
                                                        future: connect_api.asesorUser(http.Client(), typeAsesoria[2], widget.token),
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
                                          height: 15,
                                          width: 25,
                                          circular: 10,
                                          color: const Color.fromRGBO(76, 142, 48, 20),
                                          namebutton: "Consultar",
                                        ),
                                      ]))
                                ],
                              )
                            ],
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 185,
                    width: 450,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 10,
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              const Text(
                                'BOTON DE EMERGENCIA MEDICA',
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color.fromRGBO(30, 65, 96, 50)),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Image(
                                        image: AssetImage('images/boton_emergencia.png'),
                                        height: 100,
                                        width: 25,
                                        color: Color.fromRGBO(78, 76, 76, 50),
                                      )),
                                  Flexible(
                                      flex: 2,
                                      fit: FlexFit.tight,
                                      child: Column(children: [
                                        const Text('Encuentra una grua o un mecanico donde estes',
                                            softWrap: true,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 18, color: Colors.grey)),
                                        const SizedBox(height: 20),
                                        ButtonWidget(
                                          function: (){
                                            setState(() {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) => AlertDialog(
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                    title: const Text("BOTON DE EMERGENCIA MEDICA",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
                                                    content: FutureBuilder<List<Assesor>>(
                                                        future: connect_api.asesorUser(http.Client(), typeAsesoria[3], widget.token),
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
                                          namebutton: "Consultar",
                                          circular: 10,
                                          height: 15,
                                          width: 25,
                                          color: const Color.fromRGBO(76, 142, 48, 20),
                                        ),
                                      ]))
                                ],
                              )
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}