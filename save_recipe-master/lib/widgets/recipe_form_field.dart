import 'package:flutter/material.dart';
import 'package:saverecipe/constant.dart';

class RecipeFormField extends StatelessWidget {
   RecipeFormField({
 
    required this.textEditingController,
    required this.onSaved,
    required this.validator,
    required this.hintText
  });

  final TextEditingController textEditingController;
  void  onSaved;
  final FormFieldValidator<String> validator;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: kBorderColor),
      ),
      height: 50,
      alignment: Alignment.center,
      child: TextFormField(
        onSaved: onSaved,
        controller: textEditingController ?? null,
        decoration: InputDecoration.collapsed(
          hintText: hintText,
        ),
        validator: validator,
      ),
    );
  }
}
