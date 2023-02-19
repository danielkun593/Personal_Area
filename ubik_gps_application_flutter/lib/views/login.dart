// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ubik_gps_application_flutter/components/buttonDesign.dart';
import 'package:ubik_gps_application_flutter/components/buttonIconDesign.dart';
import 'package:ubik_gps_application_flutter/components/decorationBackground.dart';
import 'package:ubik_gps_application_flutter/components/editTextField.dart';
import 'package:ubik_gps_application_flutter/components/logoWidget.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_login.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_ubik.dart';
import 'package:ubik_gps_application_flutter/src/models/sharedPreferencesClass.dart';
import 'package:ubik_gps_application_flutter/views/forgetPassword.dart';
import 'package:ubik_gps_application_flutter/views/register_user.dart';
import 'package:ubik_gps_application_flutter/views/splashPage.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  String _email, _password;
  bool emailCorrect = true;
  ApiLogin connectLogin = ApiLogin();
  bool isInAsyncCall = false;
  bool loginSucces = false;
  bool obscureText = true;

  final email = TextEditingController();
  final password = TextEditingController();
  UserPreferences userPreferences = UserPreferences();

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
                padding: EdgeInsets.only(right: 35, left: 35, top: MediaQuery.of(context).size.height * 0.45),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                    Container(
                      padding: const EdgeInsets.only(left: 5, right: 5, top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Inicio de sesion", style: TextStyle(fontSize: 33, fontWeight: FontWeight.w700, color: Colors.white)),
                          ButtonIconWidget(
                            namebutton: '',
                            function: (){setState((){logIn();});},
                            iconData: Icons.login,
                            size: 50,
                            circular: 20,
                            color: const Color(0xffbb1515),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            flex: 1,
                            child: ButtonWidget(
                              function: (){
                                Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const ForgetPassword()));
                              },
                              height: 10,
                              width: 5,
                              circular: 15,
                              color: const Color(0xffbb1515),
                              namebutton: "¿Olvidaste tu contraseña?",
                            ),
                          ),
                          const SizedBox(width: 15),
                          Flexible(
                            flex: 1,
                            child: ButtonWidget(
                              function: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> const Register()));
                              },
                              height: 10,
                              width: 5,
                              circular: 15,
                              color: const Color(0xffbb1515),
                              namebutton: "¿No tienes cuenta? Registrate aqui",
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.translate,
                              color: Colors.white,
                            ),
                            label: const Text(
                              "Español",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                side: const BorderSide(color: Colors.white, width: 2),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
                          )
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
  logIn() async {
    isInAsyncCall = true;
    _email = email.text;
    _password = password.text;
    userPreferences.setEmail(_email);
    userPreferences.setPassword(_password);
    if (_email.isEmpty && _password.isEmpty) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Inicio de sesion fallido", textAlign: TextAlign.center),
                content: const Text("Campos correo y contraseña son requeridos"),
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
                title: const Text("Inicio de sesion fallido", textAlign: TextAlign.center),
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
                title: const Text("Inicio de sesion fallido"),
                content: const Text("Campo contraseña requerido\nVerifique sus datos e intente nuevamente"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cerrar")),
                ],
              ));
    } else {
      loginSucces = await connectLogin.logIn(_email, _password);
      if (loginSucces == true) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SplashPage()));
      } else if (loginSucces == false) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Inicio de sesion fallido", textAlign: TextAlign.center),
                  content: const Text("Campos de correo y/o contraseña incorrectos\nVerifique sus datos e intente nuevamente"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Close")),
                  ],
                ));
      }
    }
    isInAsyncCall = false;
  }
}