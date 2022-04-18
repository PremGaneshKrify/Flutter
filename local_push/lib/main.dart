import 'dart:developer';
import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/material.dart';
import 'package:local_push/widgets/local_notification_widget.dart';

void main() {
  ansiColorDisabled = false;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String appTitle = 'Local Notifications';
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: appTitle,
        home: MainPage(appTitle: appTitle),
      );
}

class MainPage extends StatelessWidget {
  final String appTitle;

  const MainPage({required this.appTitle});

  @override
  Widget build(BuildContext context) {
    log('* * *  🤩 APP STARTED 🤩  * * * [GREEN]');
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: LocalNotificationWidget(),
      ),
    );
  }
}
