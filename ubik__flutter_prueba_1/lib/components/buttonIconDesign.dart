import 'package:flutter/material.dart';

class ButtonIconWidget extends StatelessWidget{
  final Function function;
  final Color color;
  final String namebutton;
  final IconData iconData;
  final double size;
  final double circular;

  const ButtonIconWidget({
    Key key,
    this.function,
    this.color,
    this.namebutton,
    this.iconData,
    this.size,
    this.circular
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: function,
      style: ElevatedButton.styleFrom(
          elevation: 5,
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(circular)),
          padding: const EdgeInsets.all(10)),
      label: Text(namebutton, softWrap: true, style: const TextStyle(fontSize: 20), textAlign: TextAlign.center),
      icon: Icon(iconData, size: size),
    );
  }
}