import 'dart:developer';
import 'package:chatting_using_firebase/helper/constants.dart';
import 'package:chatting_using_firebase/helper/helperfunctions.dart';
import 'package:chatting_using_firebase/services/auth.dart';
import 'package:chatting_using_firebase/services/database.dart';
import 'package:chatting_using_firebase/views/searchscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../helper/authenticate.dart';
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
  String? user;
  AuthServices authServices = AuthServices();
  HelperFunctions helperFunctions = HelperFunctions();

  String? token;

  chatRoomList() {
    final Stream<QuerySnapshot> chatRoomStream = FirebaseFirestore.instance
        .collection("ChatRoom")
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
              );
            }).toList(),
          );
        });
  }

  @override
  void initState() {
    getUserInfo();
    storeNotificationToken();
    super.initState();
  }

  storeNotificationToken() async {
    token = await FirebaseMessaging.instance.getToken();
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'token': token}, SetOptions(merge: true));
    print(token);
    log("-----------------------store token-----------------------");
  }

  getUserInfo() async {
    var v = await HelperFunctions.getUserNameSharedPreference();

    setState(() {
      Constants.myName = v.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Hello ${Constants.myName}"),
        backgroundColor: Colors.black,
        actions: [
          GestureDetector(
            onTap: (() {
              authServices.signOut();
              setState(() {
                HelperFunctions.saveUserLoggedInSharedPreference(false);
                HelperFunctions.saveUserNameSharedPreference("");
                HelperFunctions.saveUserEmailSharedPreference("");
                HelperFunctions.saveUserUIDSharedPreference('');
                Constants.myName = '';
              });
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Authenticate(),
                ),
              );
            }),
            child: const Icon(Icons.exit_to_app),
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
  const MessageTile(
      {Key? key, required this.userName, required this.chatRoomID})
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
    print("reecviced data ${widget.userName}");
    return GestureDetector(
      onTap: (() async {
        await databaseMethods.getUserByUserName(widget.userName).then((value) {
          setState(() {
            searchsnapshot = value;
          });
          searchsnapshot = value;
          setState(() {
            searchUsertoken = searchsnapshot.docs[0]["token"];
          });
        });

        log("____________________________________________________________");
        print("user token from chatroom $searchUsertoken");
        log("____________________________________________________________");
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
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: SizedBox(
          height: 80,
          width: 30,
          child: Center(
              child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
                child: Center(
                    child: Text(widget.userName.substring(0, 1).toUpperCase())),
                //   child: Center(
                //       child: Lottie.asset("assets/images/pofile.male.json")),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  widget.userName,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
