import 'package:flutter/material.dart';

import 'montserrat_text_widget.dart';
class CustomButton extends StatelessWidget {
  const CustomButton({Key? key,
    required this.fontWeight,
    required this.fontSize,
    required this.text,
    required this.height,
    required this.width,
    required this.buttonColor,
    required this.textColor
  }) : super(key: key);
  final double height;
  final double width;
  final Color buttonColor;
  final String text;
  final FontWeight fontWeight;
  final Color textColor;
  final double fontSize;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color:buttonColor,
          borderRadius: BorderRadius.circular(150)
      ),
      child:  Center(
        child: MontserratText(
            text: text,
            fontWeight: FontWeight.bold,
            color: textColor,
            fontSize: fontSize),
      ),
    );
  }
}
