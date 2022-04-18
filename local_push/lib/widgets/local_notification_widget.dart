import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_push/screen/second_screen.dart';
import '../local_notifications_helper.dart';

class LocalNotificationWidget extends StatefulWidget {
  const LocalNotificationWidget({Key? key}) : super(key: key);

  @override
  _LocalNotificationWidgetState createState() =>
      _LocalNotificationWidgetState();
}

class _LocalNotificationWidgetState extends State<LocalNotificationWidget> {
  /// Here Initializing the instance for local notifications
  final notifications = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    log("* * * The initial state has been initialized for the main screen * * * ");
    super.initState();
    log('* * * Android Initialization started * * *');

    /// Constructs an instance of AndroidInitializationSettings.
    /// Means It will allow android devices to let the notifications locally
    const settingsAndroid =  AndroidInitializationSettings('@mipmap/ic_launcher');
    log("SettingsAndroid: $settingsAndroid");
    log('* * * Android Initialization ended * * *');

    /// Constructs an instance of IOSInitializationSettings.
    /// Means It will make us to allow local notifications
      const  settingsIOS =  IOSInitializationSettings(
        requestAlertPermission: true,/// To request alert permission from user
        requestBadgePermission:  true,/// To request badge permission from user
        requestSoundPermission: true,/// To request sound permission from user
        // onDidReceiveLocalNotification: (
        //     int id,
        //     String? title,
        //     String? body,
        //     String? payload,) async {
        //   log('* * * IOS Initialization started * * *');
        //    await onSelectNotification(payload!);
        //   log('* * * IOS Initialization ended * * *');
        // }
    );
      log('SettingsIOS: $settingsIOS');

    notifications.initialize(InitializationSettings(android: settingsAndroid, iOS: settingsIOS),
        onSelectNotification: onSelectNotification);
  }
  onSelectNotification(String? payload)  {
     Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondPage(payload: payload.toString())),
    );
  }


  @override
  Widget build(BuildContext context) {
    log('📕: ERROR MESSAGE [RED] 💔');
    log('Testing message in red color [YELLOW]');
    log('Testing message in red color [PINK]');
    log("* * *  HOME SCREEN STARTED * * * [GREEN]");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children:[
          title('Basics'),
          /// Show Notification Button
          ElevatedButton(
              child: const Text('Show notification'),
              onPressed: () {
                log('SHOW NOTIFICATION TAPPED................');
                showOngoingNotification(notifications,
                    title: 'Show Notification title', body: 'Body');
              }
          ),
          ///Replace Notification Button
          ElevatedButton(
              child: const Text('Replace notification'),
              onPressed: () {
                log('🚨 Replaced Notification is Taped 🚨');
                showOngoingNotification(notifications,
                    title: 'Replaced Notification Title', body: 'ReplacedBody');
              }
          ),
          /// Other Notification Button
          ElevatedButton(
              child: const Text('Other notification'),
              onPressed: () {
                log('🚨 Other notifications is Taped🚨 ');
                showOngoingNotification(notifications,
                    title: 'Other Title', body: 'OtherBody', id: 20);
              }
          ),
          const SizedBox(height: 32),
          /// Title widget
          title('Features'),
          /// Silent Notification Button
          ElevatedButton(
              child:const Text('Silent notification'),
              onPressed: () {
                showSilentNotification(notifications,
                    title: 'SilentTitle', body: 'SilentBody', id: 30);
              }
          ),
          const SizedBox(height: 32),
          title('Cancel'),
          /// Cancel all Notification Button
          ElevatedButton(
            child: const Text('Cancel all notification'),
            onPressed: notifications.cancelAll,
          ),
        ],
      ),
    );
  }


  Widget title(String text) => Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    child: Text(
      text,
      style: Theme.of(context).textTheme.headline6,
      textAlign: TextAlign.center,
    ),
  );
}