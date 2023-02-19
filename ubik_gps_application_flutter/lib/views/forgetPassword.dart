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

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key key}) : super(key: key);

  @override
  ForgetPasswordState createState() => ForgetPasswordState();
}

class ForgetPasswordState extends State<ForgetPassword> {
  String _email;
  bool emailCorrect = true;
  bool isInAsyncCall = false;
  bool registerSucces = false;
  bool obscureText = true;
  ApiUbik connectRegister = ApiUbik();

  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: DecorationBack.backgroundGradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            const LogoUbik(logo: 'images/logo_ubik_gps.png', padding: EdgeInsets.only(top: 40, left: 80)),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(right: 35, left: 35, top: MediaQuery.of(context).size.height * 0.2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: TextString(text: "Correo electronico de recuperacion"),
                    ),
                    const SizedBox(height: 10),
                    EditTextField(
                      textEditingController: email,
                      textInputType: TextInputType.emailAddress,
                      icon: const Icon(Icons.email),
                      hintext: "Correo electronico",
                    ),
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
                              },
                              width: 50,
                              height: 20,
                              circular: 15,
                              color: const Color(0xffbb1515),
                              namebutton: "Verificar / enviar",
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
}