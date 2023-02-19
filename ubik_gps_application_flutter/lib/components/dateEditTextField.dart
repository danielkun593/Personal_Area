import 'package:flutter/material.dart';

class DateEditTextField extends StatelessWidget{
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final Icon icon;
  final String hintext;
  final VoidCallback onTap;

  const DateEditTextField({
    Key key,
    this.textEditingController,
    this.textInputType,
    this.icon,
    this.hintext,
    this.onTap
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      keyboardType: textInputType,
      readOnly: true,
      onTap: onTap,
      decoration: InputDecoration(
        prefixIcon: icon,
        hintText: hintext,
        contentPadding: const EdgeInsets.all(24),
        fillColor: Colors.white,
        filled: true,
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 3), borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
  }
}