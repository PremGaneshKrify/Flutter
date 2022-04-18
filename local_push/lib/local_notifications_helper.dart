import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';

NotificationDetails get _noSound {
  const androidChannelSpecifics = AndroidNotificationDetails(
    'silent channel id',
    'silent channel name',
    channelDescription: 'silent channel description',
    playSound: false,
  );
  final iOSChannelSpecifics = IOSNotificationDetails(presentSound: false);

  return NotificationDetails(android: androidChannelSpecifics, iOS: iOSChannelSpecifics);
}

Future showSilentNotification(
    FlutterLocalNotificationsPlugin notifications,
    {
      required String title,
      required String body,
      int id = 0,
    }) =>
    _showNotification(notifications,
        title: title, body: body, id: id, type: _noSound);

NotificationDetails get _ongoing {
  const androidChannelSpecifics =  AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    channelDescription: 'your channel description',
    importance: Importance.max,
    priority: Priority.high,
    ongoing: true,
    autoCancel: false,
  );
  const iOSChannelSpecifics = IOSNotificationDetails();
  return NotificationDetails(android: androidChannelSpecifics, iOS: iOSChannelSpecifics);
}

 Future showOngoingNotification(FlutterLocalNotificationsPlugin notifications, {required String title, required String body, int id = 0,}){
  log('showOngoingNotification function called......................');
  log('The title for show notification is: $title ');
  log('The body for show notification is: $body ');
  log('The body for show notification is: $id ');
  return _showNotification(notifications, title: title, body: body, id: id, type: _ongoing);
}

Future _showNotification(
    FlutterLocalNotificationsPlugin notifications, {
      required String title,
      required String body,
      required NotificationDetails type,
      int id = 0,
    }) =>
    notifications.show(id, title, body, type);