import 'package:flutter/material.dart';

import '../helpers/theme_colors.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {Key? key,
      required this.focusname,
      required this.controller,
      this.prefixText,
      required this.textInputType})
      : super(key: key);
  var focusname;
  final TextEditingController controller;
  final String? prefixText;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        autofocus: true,
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(focusname);
        },
        controller: controller,
        keyboardType: textInputType,
        cursorColor: SajiloKhata().lightPink,
        decoration: InputDecoration(
        
        
            border: InputBorder.none,
            labelStyle: TextStyle(color: SajiloKhata().lightPink),
            prefixText: prefixText,
            contentPadding: const EdgeInsets.only(
                left: 10, right: 10, top: 10, bottom: 10)),
      ),
    );
  }
}
