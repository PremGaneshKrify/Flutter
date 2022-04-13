import 'dart:developer';

import 'package:chatting_using_firebase/helper/constants.dart';
import 'package:chatting_using_firebase/helper/helperfunctions.dart';
import 'package:chatting_using_firebase/services/auth.dart';
import 'package:chatting_using_firebase/views/searchscreen.dart';
import 'package:flutter/material.dart';

import '../helper/authenticate.dart';

class ChatRoom extends StatefulWidget {
  final String? userNameFromSignin;
  const ChatRoom({Key? key, required this.userNameFromSignin})
      : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  String? user;
  AuthServices authServices = AuthServices();
  HelperFunctions helperFunctions = HelperFunctions();

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
    getUserInfo();
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.myName),
        actions: [
          GestureDetector(
            onTap: (() {
              authServices.signOut();
              setState(() {
                HelperFunctions.saveUserLoggedInSharedPreference(false);
                HelperFunctions.saveUserNameSharedPreference("");
                HelperFunctions.saveUserEmailSharedPreference("");
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
      body: Container(),
    );
  }
}
