import 'package:flutter/material.dart';

class SharedUbications extends StatelessWidget {
  const SharedUbications({Key key}) : super(key: key);

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
          title: const Text("COMPARTIR UBICACION"),
          titleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
          backgroundColor: Colors.transparent
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text("Home", style: TextStyle(fontSize: 25)),
                  Text("Home", style: TextStyle(fontSize: 25)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
