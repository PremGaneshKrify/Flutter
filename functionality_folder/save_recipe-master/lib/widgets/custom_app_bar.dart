import 'package:flutter/material.dart';
import 'package:saverecipe/constant.dart';

class CustomAppBar extends StatelessWidget {
  final List<Widget> actions;
  final String title;

  const CustomAppBar({ required this.actions, this.title = ""})
    ;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: kAppGradient,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 30,
            fontFamily: "Helvetica Neue",
          ),
        ),
        backgroundColor: Colors.transparent,
        actions: actions,
      ),
    );
  }
}
