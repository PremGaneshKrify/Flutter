import 'package:flutter/material.dart';

class MontserratText extends StatelessWidget {
  const MontserratText(
      {Key? key,
      required this.text,
      required this.fontWeight,
      required this.color,
      required this.fontSize})
      : super(key: key);
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            fontSize: fontSize,
            fontFamily: 'Montserrat',
            fontWeight: fontWeight,
            color: color));
  }
}
