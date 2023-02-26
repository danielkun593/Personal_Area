import 'package:flutter/material.dart';

class DecorationBack{
  static const backgroundGradient = BoxDecoration(
    gradient: LinearGradient(colors: [
      Color(0xff170101),
      Color(0xFF360505),
      Color(0xFF490C0C),
      Color(0xff980d0d),
      Color(0xffbb0404),
    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
  );
  static const backColorCard = Color(0xFF651A1A);
}