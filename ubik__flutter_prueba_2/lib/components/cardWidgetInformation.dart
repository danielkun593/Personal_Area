import 'package:flutter/material.dart';

class CardWidgetInformation extends StatelessWidget{

  final double height;
  final double width;
  final double radius;
  final Widget child;
  final EdgeInsets padding;

  const CardWidgetInformation({
    Key key,
    this.height,
    this.width,
    this.radius,
    this.padding,
    this.child
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: SizedBox(
        height: height,
        width: width,
        child: Container(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}