import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget{
  final VoidCallback function;
  final Color color;
  final double width;
  final double height;
  final double circular;
  final String namebutton;

  const ButtonWidget({
    Key key,
    this.function,
    this.color,
    this.width,
    this.height,
    this.circular,
    this.namebutton
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      style: ElevatedButton.styleFrom(
          elevation: 5,
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(circular)),
          padding: EdgeInsets.symmetric(vertical: height, horizontal: width)),
      child: Text(namebutton, softWrap: true, style: const TextStyle(fontSize: 20), textAlign: TextAlign.center),
    );
  }
}