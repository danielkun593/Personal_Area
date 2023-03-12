import 'package:flutter/material.dart';

class TextString extends StatelessWidget{

  final String text;

  const TextString({Key key,
    this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold),
        softWrap: true
    );
  }
}