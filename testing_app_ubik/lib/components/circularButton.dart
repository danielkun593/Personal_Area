import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget{
  final Function function;
  final Color color;
  final String nameButton;
  final IconData iconData;
  final double size;

  const CircularButton({
    Key key,
    this.function,
    this.color,
    this.nameButton,
    this.iconData,
    this.size
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: function,
          style: ElevatedButton.styleFrom(
              elevation: 5,
              backgroundColor: color,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(10)),
          child: Icon(iconData, size: size),
        ),
        const SizedBox(height: 10),
        Text(nameButton, softWrap: true, style: const TextStyle(fontSize: 20), textAlign: TextAlign.center),
      ],
    );
  }
}