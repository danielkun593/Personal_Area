import 'package:flutter/material.dart';

class Notificacion extends StatelessWidget {
  const Notificacion({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xff170101),
                Color(0xFF360505),
                Color(0xFF490C0C),
                Color(0xff980d0d),
                Color(0xffbb0404),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          ),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Text("NOTIFICACIONES"),
              titleTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
              backgroundColor: Colors.transparent,
            ),
            body: SingleChildScrollView(
              child: Container(
                width: 500,
                padding: const EdgeInsets.only(
                    right: 20,
                    left: 20,
                    top: 20,
                    bottom: 120
                ),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 10,
                ),
              ),
            )
        )
    );


  }

}
