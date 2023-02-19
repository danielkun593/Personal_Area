// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ubik_gps_application_flutter/components/buttonDesign.dart';
import 'package:ubik_gps_application_flutter/components/decorationBackground.dart';
import 'package:ubik_gps_application_flutter/components/editTextField.dart';
import 'package:ubik_gps_application_flutter/components/logoWidget.dart';
import 'package:ubik_gps_application_flutter/components/textString.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_register.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_ubik.dart';
import 'package:ubik_gps_application_flutter/views/login.dart';
import 'package:ubik_gps_application_flutter/icons/icon_create.dart';

class RegisterDevice extends StatefulWidget {
  const RegisterDevice({Key key}) : super(key: key);

  @override
  RegisterDeviceState createState() => RegisterDeviceState();
}

class RegisterDeviceState extends State<RegisterDevice> {
  String _name, _email, _password, _phone;
  bool emailCorrect = true;
  bool isInAsyncCall = false;
  bool registerSucces = false;
  bool obscureText = true;
  ApiRegister register = ApiRegister();

  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: DecorationBack.backgroundGradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            const LogoUbik(logo: 'images/logo_ubik_gps.png', padding: EdgeInsets.only(top: 90, left: 80)),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(right: 35, left: 35, top: MediaQuery.of(context).size.height * 0.25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: TextString(text: "Datos del dispositivo"),
                    ),
                    const SizedBox(height: 10),
                    EditTextField(
                      //textEditingController: simcard,
                      textInputType: TextInputType.text,
                      icon: const Icon(Icons.sim_card),
                      hintext: "Operadora del SIM Ej: Claro, Movistar, etc.",
                    ),
                    const SizedBox(height: 15),
                    EditTextField(
                      textEditingController: phone,
                      textInputType: TextInputType.phone,
                      icon: const Icon(Icons.phone),
                      hintext: "Numero de la tarjeta SIM Ej: 091238476",
                    ),
                    const SizedBox(height: 15),
                    EditTextField(
                      //textEditingController: imei,
                      textInputType: TextInputType.text,
                      icon: const Icon(Icons.device_hub),
                      hintext: "Imei. Revisar dispopsitivo",
                    ),
                    const SizedBox(height: 15),
                    //BUTTON
                    ButtonBar(
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: ButtonWidget(
                            function: (){
                              Navigator.pop(context, MaterialPageRoute(builder: (ctx) => const Login()));
                            },
                            width: 50,
                            height: 20,
                            circular: 10,
                            color: const Color(0xffbb1515),
                            namebutton: "Registrar Dispositivo",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> registerDataUser()async{
    /*register() async {
    isInAsyncCall = true;
    _name = name.text;
    _email = email.text;
    _password = password.text;
    if (_name.isEmpty && _email.isEmpty && _password.isEmpty) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Registro fallido", textAlign: TextAlign.center),
            content: const Text("Campos vacios, llenar los campos requeridos"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cerrar")),
            ],
          ));
    } else if (_name.isEmpty) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Registro fallido", textAlign: TextAlign.center),
            content: const Text("Campo nombre es requerido\nIngrese su nombre e intente nuevamente"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cerrar")),
            ],
          ));
    } else if (_email.isEmpty) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Registro fallido", textAlign: TextAlign.center),
            content: const Text("Campo correo es requerido\nIngrese su correo e intente nuevamente"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cerrar")),
            ],
          ));
    } else if (_password.isEmpty) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Registro fallido"),
            content: const Text("Campo contraseña requerido\nIngrese su contraseña e intente nuevamente"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cerrar")),
            ],
          ));
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Registro Exitoso"),
            content: const Text("Ya puedes iniciar sesiòn con tu cuenta"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child: const Text("Volver al login")),
            ],
          ));
    }
    isInAsyncCall = false;
  }*/
  }
}