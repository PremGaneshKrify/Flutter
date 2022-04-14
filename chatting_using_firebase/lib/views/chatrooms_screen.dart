import 'dart:developer';

import 'package:chatting_using_firebase/helper/constants.dart';
import 'package:chatting_using_firebase/helper/helperfunctions.dart';
import 'package:chatting_using_firebase/services/auth.dart';
import 'package:chatting_using_firebase/views/searchscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../helper/authenticate.dart';
import 'conversation_screen.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  String? user;
  AuthServices authServices = AuthServices();
  HelperFunctions helperFunctions = HelperFunctions();

  // chatRoomList() {
  //   final Stream<QuerySnapshot> chatRoomStream = FirebaseFirestore.instance
  //       .collection("ChatRoom")
  //       .where("users", arrayContains: Constants.myName)
  //       .snapshots();
  //   return StreamBuilder<QuerySnapshot>(
  //       stream: chatRoomStream,
  //       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //         if (snapshot.hasError) {
  //           return const Text('Something went wrong');
  //         }

  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return const Text("Loading");
  //         }

  //         return ListView(
  //           children: snapshot.data!.docs.map((DocumentSnapshot document) {
  //             Map<String, dynamic> data =
  //                 document.data()! as Map<String, dynamic>;
  //             return Padding(
  //               padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
  //               child: Container(
  //                 height: 50,
  //                 width: 30,
  //                 decoration: const BoxDecoration(color: Colors.grey),
  //                 child: Center(
  //                     child: Row(
  //                   children: [
  //                     Container(
  //                       child: Text("${data["users"][0]}"),
  //                     ),
  //                     Text(
  //                       "${data["users"][0]}",
  //                       style: const TextStyle(fontSize: 20),
  //                     ),
  //                   ],
  //                 )),
  //               ),
  //             );
  //           }).toList(),
  //         );
  //       });
  // }

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
                ChatRoomID: data["chatRoomId"],
                userName: data["chatRoomId"]
                    .toString()
                    .replaceAll("-", "")
                    .replaceAll(Constants.myName, ''),
              );
            }).toList(),
          );
        });
  }

  getUserInfo() async {
    var v = await HelperFunctions.getUserNameSharedPreference();
    setState(() {
      Constants.myName = v.toString();
    });

    log("Got user name from shared preference");
    log(user.toString());
  }

  @override
  Widget build(BuildContext context) {
    if (Constants.myName.isEmpty) {
      getUserInfo();
      //  chatRoomList();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello ${Constants.myName}"),
        actions: [
          GestureDetector(
            onTap: (() {
              authServices.signOut();
              setState(() {
                HelperFunctions.saveUserLoggedInSharedPreference(false);
                HelperFunctions.saveUserNameSharedPreference("");
                HelperFunctions.saveUserEmailSharedPreference("");
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Searchscreen(),
            ),
          );
        },
        child: const Icon(Icons.search),
      ),
      body: Container(
        child: chatRoomList(),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String userName;
  final String ChatRoomID;
  const MessageTile(
      {Key? key, required this.userName, required this.ChatRoomID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConversationScreen(
              chatRoomId: ChatRoomID.toString(),
              searchResultName: userName,
            ),
          ),
        );
      }),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: SizedBox(
          height: 50,
          width: 30,
          child: Center(
              child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(50)),
                child:
                    Center(child: Text(userName.substring(0, 1).toUpperCase())),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  userName,
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
