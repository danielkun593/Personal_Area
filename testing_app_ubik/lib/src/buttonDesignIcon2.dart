import 'package:flutter/material.dart';

class ButtonIconWidget2 extends StatelessWidget{
  final VoidCallback function;
  final Icon icon;
  final Color color;
  final double width;
  final double height;
  final double circular;
  final String namebutton;

  const ButtonIconWidget2({
    Key key,
    this.function,
    this.icon,
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(circular),
          ),
          backgroundColor: color),
      child: SizedBox(
        width: width,
        height: height,
        child: Row(
          children: [
            Expanded(flex: 1, child: icon),
            const SizedBox(width: 10),
            Expanded(
                flex: 3,
                child: Text(namebutton,
                    softWrap: true, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))
          ],
        ),
      ),
    );
  }
}