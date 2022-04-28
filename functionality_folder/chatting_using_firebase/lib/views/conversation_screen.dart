import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:chatting_using_firebase/helper/constants.dart';
import 'package:chatting_using_firebase/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import '../helper/helperfunctions.dart';
class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  final String searchResultName;
  final String searchUserToken;

  const ConversationScreen(
      {Key? key,
      required this.chatRoomId,
      required this.searchResultName,
      required this.searchUserToken})
      : super(key: key);

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  TextEditingController messageTextEditingController = TextEditingController();
  DatabaseMethods databaseMethods = DatabaseMethods();
  Stream? chatMessageStream;
  final ScrollController _scrollController = ScrollController();
  String? token;
  String? currentUsertoken;
  bool sendbutton = false;
  var count = 0;
  @override
  void initState() {
    HelperFunctions.saveSearchUserNameSharedPreference(widget.searchResultName);
    requestPermission();
    HelperFunctions.saveStopNotificationsSharedPreference(true);
    count = 1;
    super.initState();
  }

  @override
  void dispose() {
    HelperFunctions.saveSearchUserNameSharedPreference('null');
    super.dispose();
  }

  chatMessageList() {
    final Stream<QuerySnapshot> messagesList = FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(widget.chatRoomId)
        .collection("chats")
        .orderBy("time", descending: false)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: messagesList,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          controller: _scrollController,
          shrinkWrap: true,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            Timer(
                const Duration(milliseconds: 1),
                () => _scrollController
                    .jumpTo(_scrollController.position.maxScrollExtent));
            //have to play sound here
            return Padding(
                padding: const EdgeInsets.all(6.0),
                child: data["sendBy"] != Constants.myName
                    ? Container(
                        alignment: Alignment.topLeft,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.80,
                          ),
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(vertical: 1),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 18, 98, 21),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                                bottomRight: Radius.circular(40)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                data['message'],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                data['time'].toString(),
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        alignment: Alignment.topRight,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.80,
                          ),
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(vertical: 1),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 52, 59, 66),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                                bottomLeft: Radius.circular(40)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                data['message'],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                data['time'].toString(),
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ));
          }).toList(),
        );
      },
    );
  }

  // void showNotification() {
  //   setState(() {});
  //   flutterLocalNotificationsPlugin.show(
  //     0,
  //     "Testing ",
  //     "How you doing  ",
  //     NotificationDetails(
  //       android: AndroidNotificationDetails(channel.id, channel.name,
  //           importance: Importance.high,
  //           color: Colors.yellow,
  //           playSound: true,
  //           icon: '@mipmap/ic_launcher'),
  //     ),
  //   );
  // }

  sendNotification(String title, String body, String token) async {
    final data = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done',
      'message': title,
    };

    try {
      http.Response response =
          await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
              headers: <String, String>{
                'Content-Type': 'application/json',
                'Authorization':
                    'key=AAAA4a-wroo:APA91bFDIqgd3GV_uiyG5xTVrlMgfJ-PpcrtxS2-dB9L4syeLEoxO4odxbnTL9EVEpUpBg8cBBaayLqBc6PQVVst6dBg503AjINa7zBNc6TJ3vtgsebFOmIL0eyXlYPh2CjPJopAgVHB'
              },
              body: jsonEncode(<String, dynamic>{
                'notification': <String, dynamic>{
                  'title': title,
                  'body': body,
                },
                'priority': 'high',
                'data': data,
                'to': widget.searchUserToken,
              }));

      if (response.statusCode == 200) {
        log("Yeh notificatin is sended");
      } else {
        log("Error");
      }
    } catch (e) {}
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  sendMessage() {
    if (messageTextEditingController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageTextEditingController.text,
        "sendBy": Constants.myName,
        "time": DateTime.now().millisecondsSinceEpoch
      };
      databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.searchResultName),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              children: [
                Expanded(child: chatMessageList()),
                Container(
                  alignment: Alignment.bottomCenter,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextField(
                            controller: messageTextEditingController,
                            decoration: const InputDecoration(
                                hintText: "Type your message here ....",
                                hintStyle: TextStyle(color: Colors.black),
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          sendNotification(
                            Constants.myName,
                            messageTextEditingController.text,
                            widget.searchUserToken,
                          );

                          sendMessage();
                          messageTextEditingController.clear();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: 50,
                            color: Colors.white,
                            child: Lottie.asset(
                              "assets/images/blacksend.json",
                              repeat: false,
                              animate: true,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
