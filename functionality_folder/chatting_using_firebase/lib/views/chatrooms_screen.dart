import 'package:chatting_using_firebase/helper/authenticate.dart';
import 'package:chatting_using_firebase/helper/constants.dart';
import 'package:chatting_using_firebase/helper/helperfunctions.dart';
import 'package:chatting_using_firebase/services/auth.dart';
import 'package:chatting_using_firebase/services/database.dart';
import 'package:chatting_using_firebase/views/searchscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'conversation_screen.dart';
import 'package:lottie/lottie.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  String? currentusertoken;
  String? lastmessage;
  var i;
  var list = 0;
  String? user;
  AuthServices authServices = AuthServices();
  HelperFunctions helperFunctions = HelperFunctions();
  DatabaseMethods databaseMethods = DatabaseMethods();
  bool logout = false;
  String? token;
  @override
  void initState() {
    getUserInfo();
    chatRoomList();
    storeNotificationToken();
    super.initState();
  }

  chatRoomList() {
    final Stream<QuerySnapshot> chatRoomStream = FirebaseFirestore.instance
        .collection("ChatRoom")
        //  .orderBy("time", descending: true)
        .where("users", arrayContains: Constants.myName)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: chatRoomStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return MessageTile(
                userName: data["chatRoomId"]
                    .toString()
                    .replaceAll("-", "")
                    .replaceAll(Constants.myName, ''),
                chatRoomID: data["chatRoomId"],
                time: data["time"],
                lastmessage: data["lastmessage"],
                chatroomid: data["chatRoomId"],
              );
            }).toList(),
          );
        });
  }

  storeNotificationToken() async {
    token = await FirebaseMessaging.instance.getToken();
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'token': token}, SetOptions(merge: true));
  }

  getUserInfo() async {
    var v = await HelperFunctions.getUserNameSharedPreference();

    setState(() {
      Constants.myName = v.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    var name = Constants.myName.toUpperCase().toString();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Hello    $name",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        actions: [
          InkWell(
            onTap: (() async {
              logout = true;
              authServices.signOut();
              authServices.googleSignOut();
              setState(() {
                HelperFunctions.saveUserLoggedInSharedPreference(false);
                HelperFunctions.saveUserNameSharedPreference("");
                HelperFunctions.saveUserEmailSharedPreference("");
                HelperFunctions.saveUserUIDSharedPreference('');
                Constants.myName = '';
              });
              await Future.delayed(const Duration(milliseconds: 2000));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Authenticate(),
                ),
              );
            }),
            child: logout == true
                ? SizedBox(
                    child: Lottie.asset("assets/images/logout2.json",
                        height: 100, width: 100),
                  )
                : Row(
                    children: const [
                      Text("Logout"),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(Icons.exit_to_app),
                      ),
                    ],
                  ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        focusColor: Colors.yellow,
        foregroundColor: Colors.white,
        hoverColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Searchscreen(),
            ),
          );
        },
        child: Center(
          child: Lottie.asset("assets/images/lf30_editor_pgavd9wm.json"),
          heightFactor: 10,
        ),
      ),
      body: Container(
          child: Stack(
        children: [
          Container(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Lottie.asset("assets/images/77862-chatting.json"),
                ],
              )),
          chatRoomList(),
        ],
      )),
    );
  }
}

class MessageTile extends StatefulWidget {
  final String userName;
  final String chatRoomID;
  final String lastmessage;
  final String? chatroomid;

  var time;
  MessageTile(
      {Key? key,
      required this.time,
      required this.userName,
      required this.chatRoomID,
      required this.lastmessage,
      required this.chatroomid})
      : super(key: key);

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  late QuerySnapshot searchsnapshot;
  String? searchUsertoken;
  @override
  Widget build(BuildContext context) {
    String readTimestamp(int timestamp) {
      var now = DateTime.now();
      var format = DateFormat('HH:mm a');
      var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
      var diff = now.difference(date);
      int millis = widget.time;
      var dt = DateTime.fromMillisecondsSinceEpoch(millis);
      var d12 = DateFormat('hh:mm a').format(dt);
      var time = '';

      if (diff.inSeconds <= 0 ||
          diff.inSeconds > 0 && diff.inMinutes == 0 ||
          diff.inMinutes > 0 && diff.inHours == 0 ||
          diff.inHours > 0 && diff.inDays == 0) {
        //  time = format.format(date);
        time = d12;
      } else if (diff.inDays > 0 && diff.inDays < 7) {
        if (diff.inDays == 1) {
          time = diff.inDays.toString() + ' DAY AGO';
        } else {
          time = diff.inDays.toString() + ' DAYS AGO';
        }
      } else {
        if (diff.inDays == 7) {
          time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
        } else {
          time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
        }
      }

      return time;
    }

    return GestureDetector(
      onTap: (() async {
        await databaseMethods.getUserByUserName(widget.userName).then((value) {
          setState(() {
            searchsnapshot = value;
          });
          searchsnapshot = value;

          searchUsertoken = searchsnapshot.docs[0]["token"];
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConversationScreen(
              chatRoomId: widget.chatRoomID.toString(),
              searchResultName: widget.userName,
              searchUserToken: searchUsertoken!,
            ),
          ),
        );
      }),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                    child: Text(
                      widget.userName.substring(0, 1).toUpperCase(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.31,
                    child: Text(
                      widget.userName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Text(
                    widget.lastmessage,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ]),
            Text(
              //d12,
              readTimestamp(widget.time),
              style: const TextStyle(fontSize: 16),
            ),
          ],
        )),
      ),
    );
  }
}
