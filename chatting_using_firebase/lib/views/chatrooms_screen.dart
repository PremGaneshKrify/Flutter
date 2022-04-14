import 'dart:developer';

import 'package:chatting_using_firebase/helper/constants.dart';
import 'package:chatting_using_firebase/helper/helperfunctions.dart';
import 'package:chatting_using_firebase/services/auth.dart';
import 'package:chatting_using_firebase/views/searchscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../helper/authenticate.dart';

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
              return Container(
                child: Text("${data["chatRoomId"]}"),
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
