import 'package:flutter/material.dart';

class LogoUbik extends StatelessWidget{

  final String logo;
  final EdgeInsets padding;

  const LogoUbik({Key key,
    this.logo,
    this.padding
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Image.asset(logo, height: 125),
    );
  }
}