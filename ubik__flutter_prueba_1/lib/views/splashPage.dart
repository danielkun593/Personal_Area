// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ubik_gps_application_flutter/components/decorationBackground.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_login.dart';
import 'package:ubik_gps_application_flutter/src/models/userData.dart';
import 'dart:async';
import 'package:ubik_gps_application_flutter/views/content.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key, @required this.email, @required this.password}) : super(key: key);

  final String email;
  final String password;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  ApiLogin login = ApiLogin();
  Future<List<Usuario>> userData;
  String token;

  @override
  void initState() {
    super.initState();
    userData = login.dataUserHome(http.Client(), widget.email, widget.password);
    login.JWT(widget.email, widget.password, http.Client()).then((value){
      setState(() {
        token = value;
      });
    });
    Timer(
        const Duration(seconds: 3), () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Inicio(email: widget.email, password: widget.password, token: token))));
  }

  tokenInformation(List<Usuario> data){
    String token;
    for(var i in data){
      token = i.jwt;
    }
    return token;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(50),
        decoration: DecorationBack.backgroundGradient,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/logoGifUbik.gif', scale: 0.1, width: 140, height: 140,
                  ),
                  const SizedBox(height: 15),
                  const LinearProgressIndicator(
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation(Colors.red),
                    minHeight: 15,
                  ),
                  const SizedBox(height: 30),
                  const Text("Cargando...",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),
            )
        )
    );
  }
}