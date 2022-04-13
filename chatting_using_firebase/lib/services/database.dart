import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByUserName(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .get();
  }

  getUserByUserEmail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: userEmail)
        .get();
  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection('users').add(userMap).catchError((e) {
      log(e.toString());
    });
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) {
      log(e.toString());
    });
  }

  addConversationMessages(String chatRoomId, messageMap) {
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      log(e.toString());
    });
  }

  getConversationMessages(String chatRoomId) async {
    print("CONVERSATION MESSAGES..................................");
    print(FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .snapshots());
    print("CONVERSATION MESSAGES..................................");
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .snapshots();
  }
}
