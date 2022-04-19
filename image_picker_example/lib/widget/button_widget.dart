import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    required this.text,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) => RaisedButton(
        child: Text(
          text,
          style: const TextStyle(fontSize: 24),
        ),
        shape: const StadiumBorder(),
        color: Theme.of(context).colorScheme.secondary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textColor: Colors.white,
        onPressed: onClicked,
      );
}
