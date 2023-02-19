import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jsonapp/views/pantalla3.dart';

class Carga extends StatefulWidget {
  const Carga({super.key, required this.email, required this.password});

  final String email;
  final String password;

  @override
  State<Carga> createState() => _CargaState();
}

class _CargaState extends State<Carga> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5),
            ()=> Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (builder)=> ThreePage(
                        title: "Pantalla3",
                        email: widget.email,
                        password: widget.password
                    )
                )
            )
    );
  }
}
