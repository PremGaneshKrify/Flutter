import 'dart:developer';

import 'package:chatting_using_firebase/helper/constants.dart';
import 'package:chatting_using_firebase/services/database.dart';
import 'package:chatting_using_firebase/views/conversation_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({Key? key}) : super(key: key);

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  bool searchResult = false;
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController searchTextEditingController = TextEditingController();
  late QuerySnapshot searchsnapshot;
  initiateSearch() async {
    await databaseMethods
        .getUserByUserName(searchTextEditingController.text)
        .then((value) {
      setState(() {
        searchsnapshot = value;
        searchResult = true;
      });
      searchsnapshot = value;
    });
  }

  Widget searchListTile() {
    // ignore: unnecessary_null_comparison
    return ListView.builder(
        shrinkWrap: true,
        itemCount: searchsnapshot.docs.length,
        itemBuilder: (BuildContext context, int index) {
          return SearchTile(
            email: searchsnapshot.docs[0]["email"],
            userName: searchsnapshot.docs[0]["name"],
          );

          // return SearchTile(
          //   searchsnapshot.docs[0]["email"],
          //   username: searchsnapshot.docs[0]["name"],
          // );
        });
  }

  createChatroomAndStartConversation(String userName) {
    log("This is My name");
    print(Constants.myName.toString());
    String chatRoomId = getChatRoomId(userName, Constants.myName);
    Map<String, dynamic> chatRoomMap = {
      "users": userName,
      "chatRoomId": chatRoomId
    };
    databaseMethods.createChatRoom(chatRoomId, chatRoomMap);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ConversationScreen(
                  chatRoomId: chatRoomId.toString(),
                )));
  }

  // ignore: non_constant_identifier_names
  Widget SearchTile({required String email, required String userName}) {
    return Container(
        color: Colors.grey[100],
        height: 100,
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    userName,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    email,
                    style: const TextStyle(fontSize: 18),
                  )
                ],
              ),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    print("sending user name to create chat room search result $userName");
                    createChatroomAndStartConversation(userName);
                  },
                  child: const Text("MESSAGE"))
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search ")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              color: Colors.grey[100],
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchTextEditingController,
                      decoration: const InputDecoration(
                          hintText: "     Search UserName ....",
                          hintStyle: TextStyle(color: Colors.black),
                          border: InputBorder.none),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      initiateSearch();
                    },
                    child: Container(
                        height: 50,
                        width: 50,
                        color: Colors.grey[400],
                        child: const Icon(Icons.search)),
                  )
                ],
              ),
            ),
            searchResult == true ? searchListTile() : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  //
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    // print(b a);
    return "$b$a";
  } else {
    return "$a$b";
  }
}
