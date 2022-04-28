import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/retry.dart';

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

  uploadUserInfo(userMap, userUID) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc("$userUID")
        .set(userMap)
        .catchError((e) {
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
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      log(e.toString());
    });
  }

  getConversationMessages(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time")
        .snapshots(includeMetadataChanges: true);
  }

  getChatRoom(String userName) {
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: userName)
        .snapshots();
  }

  getlastmessage(chatroomid)async {
    String v = chatroomid.toString();
    String mes = "";
    FirebaseFirestore.instance
        .collection("/ChatRoom/Krify Soft-ganesh/chats")
        .orderBy("time", descending: true)
        .snapshots()
        .listen((event) {
      mes = event.docs[0]["message"].toString();
    });
     return mes;
  }
 
}
