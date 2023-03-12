import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget{
  final double height;
  final double width;
  final double circular;
  final Color color;
  final Widget widget;

  const CardWidget({
    this.height,
    this.width,
    this.circular,
    this.color,
    this.widget,
    Key key
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(circular)
        ),
        child: widget,
      ),
    );
  }
}