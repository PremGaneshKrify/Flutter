import 'package:chatting_using_firebase/helper/authenticate.dart';
import 'package:chatting_using_firebase/views/chatrooms_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'helper/helperfunctions.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: "this is descriptions",
    enableVibration: true,
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? searchUserName;
  var v;
  bool? userIsLoggedIn;
  bool? stop;
  getLoggedInState() async {
    v = await HelperFunctions.getUserNameSharedPreference();
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
      print("___________________________________________________________-");
      print(userIsLoggedIn);
    });
  }

  getSearchUserName(RemoteMessage message) async {
    print("Get Searcg USer Name method Called............................");
    var v = await HelperFunctions.getSearchUserNameSharedPreference();
    print("The value of v is : ");
    print(v);

    setState(() {
      searchUserName = v;

      showstopNotification(message, v!);
    });
  }

  @override
  void initState() {
    getLoggedInState();
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      getSearchUserName(message);
    });
  }

  showstopNotification(RemoteMessage message, String userName) {
    /// firebase messaging to open a app
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print('A new onMessageOpenedApp event was published!');
    //   RemoteNotification? notification = message.notification;

    //   AndroidNotification? android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     if (true) {
    //       showDialog(
    //           context: context,
    //           builder: (_) {
    //             return AlertDialog(
    //               title: Text(notification.title.toString()),
    //               content: SingleChildScrollView(
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [Text(notification.body.toString())],
    //                 ),
    //               ),
    //             );
    //           });
    //     } else {}
    //   }
    // });
    if (message.notification!.title != userName) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        print(
            "Fire base called...IFCASE....message..${message.notification!.title}...userName...$userName..........");
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.black,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    } else {
      print(
          "Fire base called...ELSECASE.........message..${message.notification!.title}....userName..$userName.........");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[200],
          primarySwatch: Colors.blue,
        ),
        home: userIsLoggedIn != null
            ? userIsLoggedIn == true
                ? const ChatRoom()
                : const Authenticate()
            : const Center(
                child: Authenticate(),
              ));
  }
}
