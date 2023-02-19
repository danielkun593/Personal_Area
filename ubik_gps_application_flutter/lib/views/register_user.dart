// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ubik_gps_application_flutter/components/buttonDesign.dart';
import 'package:ubik_gps_application_flutter/components/decorationBackground.dart';
import 'package:ubik_gps_application_flutter/components/editTextField.dart';
import 'package:ubik_gps_application_flutter/components/logoWidget.dart';
import 'package:ubik_gps_application_flutter/components/textString.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_ubik.dart';
import 'package:ubik_gps_application_flutter/views/login.dart';
import 'package:ubik_gps_application_flutter/icons/icon_create.dart';
import 'package:ubik_gps_application_flutter/views/register_device.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);
  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  String _name, _email, _password, _marca, _modelo, _year, _tipoVehiculo, _phone;
  bool emailCorrect = true;
  bool isInAsyncCall = false;
  bool registerSucces = false;
  bool obscureText = true;

  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final phone = TextEditingController();
  final modelo = TextEditingController();
  final marca = TextEditingController();
  final anio = TextEditingController();
  final tipoVehiculo = TextEditingController();

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
                padding: EdgeInsets.only(right: 35, left: 35, top: MediaQuery.of(context).size.height * 0.24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: TextString(text: "Datos personales"),
                    ),
                    const SizedBox(height: 10),
                    EditTextField(
                      textEditingController: name,
                      textInputType: TextInputType.text,
                      icon: const Icon(Icons.account_circle),
                      hintext: "Nombre completo",
                    ),
                    const SizedBox(height: 15),
                    EditTextField(
                      textEditingController: phone,
                      textInputType: TextInputType.phone,
                      icon: const Icon(Icons.phone),
                      hintext: "Celular/Telefono",
                    ),
                    const SizedBox(height: 15),
                    EditTextField(
                      textEditingController: email,
                      textInputType: TextInputType.emailAddress,
                      icon: const Icon(Icons.email),
                      hintext: "Correo electronico",
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: password,
                      obscureText: obscureText,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          child: Icon(obscureText ? Icons.visibility : Icons.visibility_off, size: 30),
                        ),
                        hintText: 'Contraseña',
                        contentPadding: const EdgeInsets.all(24),
                        fillColor: Colors.white,
                        filled: true,
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 3), borderRadius: BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: TextString(text: "Datos del Vehiculo"),
                    ),
                    const SizedBox(height: 10),
                    EditTextField(
                      textEditingController: modelo,
                      textInputType: TextInputType.text,
                      icon: const Icon(Icomoon.modelCar),
                      hintext: "Modelo del vehiculo",
                    ),
                    const SizedBox(height: 15),
                    EditTextField(
                      textEditingController: marca,
                      textInputType: TextInputType.text,
                      icon: const Icon(Icomoon.carUbik),
                      hintext: "Marca del vehiculo",
                    ),
                    const SizedBox(height: 15),
                    EditTextField(
                      textEditingController: modelo,
                      textInputType: TextInputType.text,
                      icon: const Icon(Icomoon.typeCar),
                      hintext: "Tipo de vehiculo",
                    ),
                    const SizedBox(height: 10),
                    //BUTTON
                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 15, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 1,
                            child: ButtonWidget(
                              function: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> const RegisterDevice()));
                              },
                              width: 50,
                              height: 10,
                              circular: 10,
                              color: const Color(0xffbb1515),
                              namebutton: "Registrar datos",
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            flex: 1,
                            child: ButtonWidget(
                              function: (){
                                Navigator.pop(context, MaterialPageRoute(builder: (ctx)=> const Login()));
                              },
                              width: 60,
                              height: 20,
                              circular: 10,
                              color: const Color(0xffbb1515),
                              namebutton: "Cancelar",
                            ),
                          ),
                        ],
                      ),
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

  register() async {
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
  }
}